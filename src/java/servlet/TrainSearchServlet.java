package com.railway.servlet;

import com.railway.dao.TrainDAO;
import com.railway.model.Train;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class TrainSearchServlet extends HttpServlet {
    private TrainDAO trainDAO;
    
    @Override
    public void init() throws ServletException {
        trainDAO = new TrainDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<String> stations = trainDAO.getAllStations();
        request.setAttribute("stations", stations);
        request.getRequestDispatcher("search.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String source = request.getParameter("source");
        String destination = request.getParameter("destination");
        
        if (source == null || destination == null || source.trim().isEmpty() || destination.trim().isEmpty()) {
            request.setAttribute("error", "Please select both source and destination");
            List<String> stations = trainDAO.getAllStations();
            request.setAttribute("stations", stations);
            request.getRequestDispatcher("search.jsp").forward(request, response);
            return;
        }
        
        if (source.equals(destination)) {
            request.setAttribute("error", "Source and destination cannot be the same");
            List<String> stations = trainDAO.getAllStations();
            request.setAttribute("stations", stations);
            request.getRequestDispatcher("search.jsp").forward(request, response);
            return;
        }
        
        List<Train> trains = trainDAO.searchTrains(source, destination);
        List<String> stations = trainDAO.getAllStations();
        
        request.setAttribute("trains", trains);
        request.setAttribute("stations", stations);
        request.setAttribute("searchPerformed", true);
        request.setAttribute("source", source);
        request.setAttribute("destination", destination);
        
        if (trains.isEmpty()) {
            request.setAttribute("message", "No trains found for the selected route");
        }
        
        request.getRequestDispatcher("search.jsp").forward(request, response);
    }
}

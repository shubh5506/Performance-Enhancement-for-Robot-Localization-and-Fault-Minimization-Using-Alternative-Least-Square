# Performance-Enhancement-for-Robot-Localization-and-Fault-Minimization-Using-Alternative-Least-Square

The purpose is to investigate proper machine learning tools for the SFU Mountain data-set. Impact: Revealing the appropriate machine learning tools will guide us to build a better data model. We are conducting semi-structured woodlands for fault diagnosis of how environmental variables affect the availability of important robotic services. Using a modeling framework, we are creating future scenarios of robotic service availability based upon local knowledge and climate projections.   In addition, we are developing models derived from inputs to compare and potentially combine with local knowledge inputs.  This allows us to assess, from several perspectives, how a critical component of community flexibility cans revolution in the future.  Perfect productivities will be used to simplify deliberations in the groups on variation options that could minimize the negative consequences while seizing upon positive opportunities.

Datasets:
The SFU Mountain Dataset involves of numerous 100 GB of sensor data verified from Burnaby Mountain, British Columbia, Canada. Each traversal covers 4km of woodland trails with a 300m altitude change. Recordings contain complete video since 6 cameras, collection data from two LIDAR sensors, GPS, IMU and wheel encoders, plus calibration parameters for each sensor, and we provide the data in the form of ROS bag files, JPEG image files, and CSV text files. Jake Bruce, Jens Wawerla, and Richard Vaughan. The SFU Mountain Dataset: Semi-Structured Woodland Trails Under Changing Environmental Conditions," in IEEE Int. Conf. on Robotics and Robotics, Factory on Visual Place Acknowledgment in Varying Surroundings. Seattle, USA, 2015.
 

Results:
In this section,results shows sample trajectory matches, fault detection rate and MSE on results plots. The current implementation has ALS optimization built in, so compute scales linearly with the length of the dataset. For all experiments, computation was performed at real-time speed or faster on a standard Intel Core i7 PC.

Steps Performed:

Step 1: Read curve's points from the Excel file

Step 2: Extract Row Co-ordinate and column too

Step 3: Define fault rate

Step 4: fault Detected Parameter Machine// Compute current from voltage vector

Step 5: Do "coerce" to limit extrap values to positive values

Step 6: fault Detection rate minimization as per coverage distance
 
Step 7: Define sigmoid function regularization for numerical stability

Step 8: Define bernoulli probability weight matrix response update

Step 9:check convergence

Step 10: compute MSE



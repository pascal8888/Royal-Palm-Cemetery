# Royal-Palm-Cemetery
A project to clean and analyze raw data collected during 2000-2001 about interments at Royal Palm Cemetary 101 55th Street South, Saint Petersburg Florida, 33707.

### From the source data:
ROYAL PALM CEMETERY, St. Petersburg, Pinellas County, Florida

File contributed for use in USGenWeb Archives by Lesleigh Laite Butts, 
(http://www.genrecords.net/emailregistry/vols/00027.html#0006568). 

USGENWEB ARCHIVES NOTICE:  These electronic pages may NOT be reproduced in any format for 
profit or publication by any other organization or persons.  Persons or organizations 
desiring to use this material, must obtain the written consent of the contributor, or the 
legal representative of the submitter, and contact the listed USGenWeb archivist with proof 
of this consent. The submitter has given permission to the USGenWeb Archives to store the 
file permanently for free access.

Copyright.  All rights reserved.
http://www.usgwarchives.net/copyright.htm

#####******************************************************************************************

Notes:  Royal Palm Cemetery is located at 101 - 55th Street S., St. 
Petersburg, Florida. Reginald H. Sumner established Royal Palm in 1921 
after purchasing 80 acres of land between Fifty-fifth and Forty-eighth 
streets and First and Ninth avenues south from Mr. George S. Gandy. A 
palm lined road leads to the cemetery offices in the middle of the tract. 
This building had once served as a chapel. Of the original parcel, 55 acres 
remain as cemetery today. There is more than a mile of winding roads that 
section off the cemetery.  

The Pinellas Genealogy Society volunteer canvassers began canvassing Royal 
Palm on October 14, 2000, completing the project on March 10, 2001. The following 
individuals participated in the survey of Royal Palm Cemetery: Trish Burch, 
Lesleigh Butts (Project Chair), Ann Cantlin, Charlie & Pat Grandmaison, Pat 
Johnston, Kerry and JoAnn McElhaney, Rae Rose and Beth Shields. The following 
individuals assisted with foreign language translation: Mrs. Alice Groman (Russian), 
Mr. Stanley Shalit (Jewish), Mrs. Nancy Keizer (Dutch). The survey resulted in 
22,069 recorded interments. Although every attempt was made to record every burial, 
the data will not reflect those buried without headstones or headstones that have 
gone below ground. PGS member Joseph C. Grandmaison completed the bulk of data 
entry on this project, his wife Pat assisting with the verification process.   
Boy Scout, Kyle Cannon, of Scout Troop 84 - West Central Florida Council supervised 
a team of volunteers who worked on finishing the final twenty five percent of this 
project to earn Kyle the rank of Eagle Scout. His team of volunteers were:  Boyd & 
Cheryl Belnap, Bruce & Phyllis Belnap, Jean Boyer, Earl Brigance, Kari & Jordan Cannon, 
Jeffrey & Kevin Cluff, Don Conrad, Larry & Diana Dean, Gene & Margie Fallon, Diane 
Griffin, Phil & Virginia Huchton, Barbara Knibbs Peter Luginbuehl, Bob McManaway, Bob 
Smith, Cesar Tolentino, Todd Williams.

This index is provided by the Pinellas Genealogy Society.  For availability of 
complete transcription and to view a cemetery photograph, visit the Pinellas 
Genealogy Society at http://www.rootsweb.com/~flpgs.

#----------------------------------------
##Repository Contents
###RoyalPalmAnalysis.R
This is the R script that takes the raw data captured in the project, cleans it, and provides a tidy data set and key derived data to aid with analysis. The script is not yet finished - the intent is to use the *shiny* R package to publish an interactive web site based on the data.
###RoyalPalmAnalysis-scrapples.R
These are just code snippets that can help with analysis.  Saved to spur thoughts and memories for the data analyst.
###README.md
This document
###RPC.txt
This is raw source file captured in the data-collection project. The introduction contained in this document is displayed above (lines 5 - 52)  RoyalPalmAnalysis.R contains extensive comments about the data anamolies found, the steps to correct some, and those that remain in the data after cleansing.
###License
This has not yet been decided as of 05/28/2015, but should be included before releasing to the public.
###Codebook.md
This codebook describes the variables of the rpc data.frame which is an output of the RoyalPalmAnalysis.R script
###RPC - newsletter.docx
This is a report written by James Schacht and published in his neighborhood newsletter about insights derived by analyzing this data.

*/Note: as of 2/5/2021, due to change in Indeed's pages the parser might no longer work correctly./*

This repo contains some Jupyter notebooks and accessory functions exploring the use of the <a href="www.structuraltopicmodel.com">Structural Topic Model</a> on a corpus of job offers scraped from indeed.co.uk. This exercies is meant to be an example of usage of stm and the relative R package, and the results presented don't have any real statistical validity.

The documents contained are:
<ul>
	<li><a href="https://github.com/fracab/STMIndeed/blob/master/CleanIndeedG.R">CleanIndeedG.R</a>: incorporate "CoordIndeedG.R" and "CleanSalaryIndeedG.R"</li>
	<li><a href="https://github.com/fracab/STMIndeed/blob/master/CoordIndeedG.R">CoordIndeedG.R</a>: function to extrapolate coordinates from vacancies on Indeed and store them in two new columns;</li>
	<li><a href="https://github.com/fracab/STMIndeed/blob/master/CleanSalaryIndeedG.R">CleanSalaryIndeedG.R</a>: function to extrapolate min and max salary and factor by which the rate is computed;</li>
	<li><span class="css-truncate css-truncate-target"><a id="1a8cd172e13dad9bcdf248a2346b21ac-db3196bca988f4eda35722c5ce68dce26e2950b4" class="js-navigation-open" title="Indeed RJupyterNB.ipynb" href="https://github.com/fracab/STMIndeed/blob/master/Indeed%20RJupyterNB.ipynb">Indeed RJupyterNB.ipynb</a>: notebook with data scraping and cleaning workflow;</span></li>
	<li><span class="css-truncate css-truncate-target"><a id="5b7de359b4ee159e7f05165c1b968382-7c78dfd2bead0d00bcc80a3c6f983f5eaaeb088c" class="js-navigation-open" title="Indeed RJupyterNB2b.ipynb" href="https://github.com/fracab/STMIndeed/blob/master/Indeed%20RJupyterNB2b.ipynb">Indeed RJupyterNB2b.ipynb</a>: notebook with model selection and overview of main functions of stm;</span></li>
	<li><span class="css-truncate css-truncate-target"><a id="d508dae3e77e440ef1ba5bfc8775c123-b496b1a4878520f4acb70ef07f915cf4cdb9dcc5" class="js-navigation-open" title="Indeed RJupyterNB3_Salaries_Location.ipynb" href="https://github.com/fracab/STMIndeed/blob/master/Indeed%20RJupyterNB3_Salaries_Location.ipynb">Indeed RJupyterNB3_Salaries_Location.ipynb</a>: notebook with analysis of topic content metadata (salary and dummy variable with location in Newcastle);</span></li>
	<li><a href="https://github.com/fracab/STMIndeed/blob/master/ScrapingIndeedCodeG.R">ScrapingIndeedCodeG.R</a>: the function presented in the first section of  "Indeed RJupyter.ipynb" to scrape data from Indeed;</li>
	<li><span class="css-truncate css-truncate-target"><a id="1ff8ae5b110297c853b5c304d301817c-6543cd12856bb8b12efab20464b47d8a2900145f" class="js-navigation-open" title="totaljobs.txt" href="https://github.com/fracab/STMIndeed/blob/master/totaljobs.txt">totaljobs.txt</a>: dataset </span></li>
	<li><span class="css-truncate css-truncate-target"><a id="40096116ed1394ed0f1b67fb93a0a7f7-79d80ca0c8da90f58463de52db34a078aa6fa5c9" class="js-navigation-open" title="totaljobsCoord.txt" href="https://github.com/fracab/STMIndeed/blob/master/totaljobsCoord.txt">totaljobsCoord.txt</a>: dataset with coordinates</span></li>
	<li><span class="css-truncate css-truncate-target"><a id="edc41d2b5790ea4b867f39bc563c9167-e2a5158be7298467640df9ef01189d582bb57a6b" class="js-navigation-open" title="totaljobsCoordRates.txt" href="https://github.com/fracab/STMIndeed/blob/master/totaljobsCoordRates.txt">totaljobsCoordRates.txt</a>: dataset with coordinates and salary rates.</span></li>
</ul>

The documents have also been published in my <a href="https://francescocaberlin.blog/category/structural-topic-model/">personal blog</a>.</li>

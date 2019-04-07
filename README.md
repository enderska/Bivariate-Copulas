# Bivariate-Copulas

Multivariate data modelling and forecasting with Copulas

Statistical modelling of the dependence structure between pairs of univariate time series using the concept of copulas. Copulas are functions that describe the dependence between two or more random variables. Three data sets are selected to illustrate the methodology, aiming to capture correlation beyond the usual linear form, such as tail and asymmetric dependence. As a back testing procedure, Monte Carlo simulations are performed to forecast conditional moments of financial Key Performance Indicators. Results are compared to linear time series models.

</head>
  <body class='markdown-preview' data-use-github-style><h1 id="get_transformed_series-calculate-required-business-transformation"><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">get_transformed_series</code>: Calculate required business transformation</h1>
<p> Calculate month-over-month or year-over-year transformation based on argument</p>
<h2 id="description">Description</h2>
<p> Calculate required business transformation
 Calculate month-over-month or year-over-year transformation based on argument</p>
<h2 id="usage">Usage</h2>
<pre class="editor-colors lang-r"><div class="line"><span class="syntax--text syntax--plain syntax--null-grammar"><span>get_transformed_series(series,&nbsp;trafo&nbsp;=&nbsp;NULL)</span></span></div></pre>
<h2 id="arguments">Arguments</h2>
<table>
<thead>
<tr>
<th>Argument</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">series</code></td>
<td>The time series which needs to be transformed</td>
</tr>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">trafo</code></td>
<td>A string which should be one of c(NULL, 'mom','yoy') to specify which transformation.</td>
</tr>
</tbody>
</table>
<h2 id="value">Value</h2>
<p> Return the transformed series.</p>
<h1 id="getcopfc-wrapper-function-for-copula-forecast"><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">getCopfc</code>: Wrapper function for copula forecast</h1>
<h2 id="description">Description</h2>
<p> Wrapper function for copula forecast</p>
<h2 id="usage">Usage</h2>
<pre class="editor-colors lang-r"><div class="line"><span class="syntax--text syntax--plain syntax--null-grammar"><span>getCopfc(KPI,&nbsp;indicator_set,&nbsp;indicator_name&nbsp;=&nbsp;NULL,&nbsp;min.lag&nbsp;=&nbsp;5,</span></span></div><div class="line"><span class="syntax--text syntax--plain syntax--null-grammar"><span>&nbsp;&nbsp;max.lag&nbsp;=&nbsp;18,&nbsp;lag&nbsp;=&nbsp;NULL,&nbsp;kpi_trafo&nbsp;=&nbsp;NULL,&nbsp;ind_trafo&nbsp;=&nbsp;NULL,</span></span></div><div class="line"><span class="syntax--text syntax--plain syntax--null-grammar"><span>&nbsp;&nbsp;KPI_outlier_corr&nbsp;=&nbsp;FALSE,&nbsp;indicator_outlier_corr&nbsp;=&nbsp;FALSE,&nbsp;offset&nbsp;=&nbsp;TRUE,</span></span></div><div class="line"><span class="syntax--text syntax--plain syntax--null-grammar"><span>&nbsp;&nbsp;dates&nbsp;=&nbsp;NULL)</span></span></div></pre>
<h2 id="arguments">Arguments</h2>
<table>
<thead>
<tr>
<th>Argument</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">KPI</code></td>
<td>The time series which needs to be predicted</td>
</tr>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">indicator_set</code></td>
<td>The set of indicators which are looked through for finding an exogeneous time series</td>
</tr>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">indicator_name</code></td>
<td>The indicator which is used to forecast the <code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">KPI</code> . If it is <code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">NULL</code> , then maximum kendall's tau is used to automatically pick the exogeneous time series</td>
</tr>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">min.lag</code></td>
<td>The minimum lead time which is looked at while picking the exogeneous time series</td>
</tr>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">max.lag</code></td>
<td>The maximum lwead time which is looked at while picking the exogeneous time series</td>
</tr>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">kpi_trafo</code></td>
<td>The transformation which is applied to the KPI before forecasting</td>
</tr>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">ind_trafo</code></td>
<td>The transformation which is applied to the indicator before forecasting</td>
</tr>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">KPI_outlier_corr</code></td>
<td>Boolean to indicate whether to perform outlier correction on the KPI</td>
</tr>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">indicator_outlier_corr</code></td>
<td>Boolean to indicate whether to perform outlier correction on the indicator</td>
</tr>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">offset</code></td>
<td>Indicates whether the copula forecast should be offset or not. The offset is determined by the</td>
</tr>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">dates</code></td>
<td>Deprecated</td>
</tr>
</tbody>
</table>
<h2 id="value">Value</h2>
<p> The median and 2 sigma forecast from the copula model</p>
<h1 id="getmape-calculate-mape"><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">getMAPE</code>: Calculate MAPE</h1>
<p> Get the mean absolute percentage error for the prediction and the target. This is one of the metrics to benchmark our results.</p>
<h2 id="description">Description</h2>
<p> Calculate MAPE
 Get the mean absolute percentage error for the prediction and the target. This is one of the metrics to benchmark our results.</p>
<h2 id="usage">Usage</h2>
<pre class="editor-colors lang-r"><div class="line"><span class="syntax--text syntax--plain syntax--null-grammar"><span>getMAPE(pred,&nbsp;target)</span></span></div></pre>
<h2 id="arguments">Arguments</h2>
<table>
<thead>
<tr>
<th>Argument</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">pred</code></td>
<td>The prediction from the model</td>
</tr>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">target</code></td>
<td>The actuals for the said period</td>
</tr>
</tbody>
</table>
<h2 id="value">Value</h2>
<p> The MAPE between the prediction and the target</p>
<h1 id="getmase-compute-mase"><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">getMASE</code>: Compute MASE</h1>
<p> Get the mean absolute square error for the prediction and the target. One of the metrics to benchamrk our results.</p>
<h2 id="description">Description</h2>
<p> Compute MASE
 Get the mean absolute square error for the prediction and the target. One of the metrics to benchamrk our results.</p>
<h2 id="usage">Usage</h2>
<pre class="editor-colors lang-r"><div class="line"><span class="syntax--text syntax--plain syntax--null-grammar"><span>getMASE(pred,&nbsp;target)</span></span></div></pre>
<h2 id="arguments">Arguments</h2>
<table>
<thead>
<tr>
<th>Argument</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">pred</code></td>
<td>The prediction from the model</td>
</tr>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">target</code></td>
<td>The actuals for the said period</td>
</tr>
</tbody>
</table>
<h2 id="value">Value</h2>
<p> The MASE between the prediction and the target</p>
<h1 id="getmaxktau-find-best-indicator-and-lead-time"><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">getMaxKtau</code>: Find best indicator and lead time</h1>
<p> Gets the indicator and lead time from a set of indicators which ahs the maximum kendall's tau with repsect to the said KPI</p>
<h2 id="description">Description</h2>
<p> Find best indicator and lead time
 Gets the indicator and lead time from a set of indicators which ahs the maximum kendall's tau with repsect to the said KPI</p>
<h2 id="usage">Usage</h2>
<pre class="editor-colors lang-r"><div class="line"><span class="syntax--text syntax--plain syntax--null-grammar"><span>getMaxKtau(KPI,&nbsp;indicators,&nbsp;max.lag&nbsp;=&nbsp;18,&nbsp;min.lag&nbsp;=&nbsp;5)</span></span></div></pre>
<h2 id="arguments">Arguments</h2>
<table>
<thead>
<tr>
<th>Argument</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">KPI</code></td>
<td>The KPi for which we wish to find an exogeneous time series and appropriate lead time</td>
</tr>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">indicators</code></td>
<td>The set of indicators which we look at to find the best exogeneous time series variable</td>
</tr>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">max.lag</code></td>
<td>The maximum lag which is considered while finding an exogeneous time series</td>
</tr>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">min.lag</code></td>
<td>The minimum lag which is considered while finding an exogeneous time series</td>
</tr>
</tbody>
</table>
<h2 id="value">Value</h2>
<p> A list conating the indicator name and the lag which provide maximum dependency with the KPI</p>
<h1 id="getmom-obtain-month-over-month-transformation"><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">getMoM</code>: Obtain month over month transformation</h1>
<h2 id="description">Description</h2>
<p> Obtain month over month transformation</p>
<h2 id="usage">Usage</h2>
<pre class="editor-colors lang-r"><div class="line"><span class="syntax--text syntax--plain syntax--null-grammar"><span>getMoM(column)</span></span></div></pre>
<h2 id="arguments">Arguments</h2>
<table>
<thead>
<tr>
<th>Argument</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">column</code></td>
<td>The vector/time series</td>
</tr>
</tbody>
</table>
<h2 id="value">Value</h2>
<p> The month over month transformation of the column</p>
<h1 id="getnorms-compute-l2-norm"><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">getNorms</code>: Compute <code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">L2</code> norm</h1>
<p> Get the <code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">L2</code> norm for each row of the matrix</p>
<h2 id="description">Description</h2>
<p> Compute <code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">L2</code> norm
 Get the <code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">L2</code> norm for each row of the matrix</p>
<h2 id="usage">Usage</h2>
<pre class="editor-colors lang-r"><div class="line"><span class="syntax--text syntax--plain syntax--null-grammar"><span>getNorms(diff_mat)</span></span></div></pre>
<h2 id="arguments">Arguments</h2>
<table>
<thead>
<tr>
<th>Argument</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">diff_mat</code></td>
<td>The matrix for which we want to calculate the norm for each row</td>
</tr>
</tbody>
</table>
<h2 id="value">Value</h2>
<p> A vector containing the <code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">L2</code> norm for each row</p>
<h1 id="getp1p2-obtain-lead-time-adjusted-kpi-and-indicator"><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">getp1p2</code>: Obtain lead time adjusted <code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">KPI</code> and <code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">indicator</code></h1>
<h2 id="description">Description</h2>
<p> Obtain lead time adjusted <code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">KPI</code> and <code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">indicator</code> </p>
<h2 id="usage">Usage</h2>
<pre class="editor-colors lang-r"><div class="line"><span class="syntax--text syntax--plain syntax--null-grammar"><span>getp1p2(KPI,&nbsp;indicator,&nbsp;lag&nbsp;=&nbsp;0)</span></span></div></pre>
<h2 id="arguments">Arguments</h2>
<table>
<thead>
<tr>
<th>Argument</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">KPI</code></td>
<td>The time series which we wish to predict</td>
</tr>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">indicator</code></td>
<td>The exogeneous time series which we use to predict the <code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">KPI</code></td>
</tr>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">lag</code></td>
<td>The lead time between the KPI and the indicator</td>
</tr>
</tbody>
</table>
<h2 id="value">Value</h2>
<p> A dataframe containing the KPI and the lead time adjusted indicator</p>
<h1 id="getrmse-compute-rmse"><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">getRMSE</code>: Compute RMSE</h1>
<p> Get the root mean square error for the prediction and the target. One of the metrics to benchamrk our results.</p>
<h2 id="description">Description</h2>
<p> Compute RMSE
 Get the root mean square error for the prediction and the target. One of the metrics to benchamrk our results.</p>
<h2 id="usage">Usage</h2>
<pre class="editor-colors lang-r"><div class="line"><span class="syntax--text syntax--plain syntax--null-grammar"><span>getRMSE(pred,&nbsp;target)</span></span></div></pre>
<h2 id="arguments">Arguments</h2>
<table>
<thead>
<tr>
<th>Argument</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">pred</code></td>
<td>The prediction from the model</td>
</tr>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">target</code></td>
<td>The actuals for the said period</td>
</tr>
</tbody>
</table>
<h2 id="value">Value</h2>
<p> The RMSE between the prediction and the target</p>
<h1 id="getseasonality-extract-seasonality"><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">getSeasonality</code>: Extract Seasonality</h1>
<p> Extract the seasonality from the <code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">data</code> vector</p>
<h2 id="description">Description</h2>
<p> Extract Seasonality
 Extract the seasonality from the <code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">data</code> vector</p>
<h2 id="usage">Usage</h2>
<pre class="editor-colors lang-r"><div class="line"><span class="syntax--text syntax--plain syntax--null-grammar"><span>getSeasonality(data,&nbsp;s.window&nbsp;=&nbsp;7,&nbsp;t.window&nbsp;=&nbsp;12)</span></span></div></pre>
<h2 id="arguments">Arguments</h2>
<table>
<thead>
<tr>
<th>Argument</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">data</code></td>
<td>The vector/time series from which the seasonality is to be extracted</td>
</tr>
</tbody>
</table>
<h2 id="value">Value</h2>
<p> The seasonality after extraction from data</p>
<h1 id="gettrend-extract-trend"><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">getTrend</code>: Extract trend</h1>
<p> Extract the trend from the <code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">data</code> vector</p>
<h2 id="description">Description</h2>
<p> Extract trend
 Extract the trend from the <code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">data</code> vector</p>
<h2 id="usage">Usage</h2>
<pre class="editor-colors lang-r"><div class="line"><span class="syntax--text syntax--plain syntax--null-grammar"><span>getTrend(data,&nbsp;s.window&nbsp;=&nbsp;7,&nbsp;t.window&nbsp;=&nbsp;12)</span></span></div></pre>
<h2 id="arguments">Arguments</h2>
<table>
<thead>
<tr>
<th>Argument</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">data</code></td>
<td>The vector/time series from which the trend is to be extracted</td>
</tr>
</tbody>
</table>
<h2 id="value">Value</h2>
<p> The trend after extraction from data</p>
<h1 id="getuseful_combs-find-useful-indicators-for-a-kpi"><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">getUseful_combs</code>: Find useful indicators for a KPI</h1>
<p> Obtain the list of combinations of KPI and indicator which have Kenadll's tau above a certain threshold. This is used to obtain KPI and indicator time series pairs</p>
<h2 id="description">Description</h2>
<p> Find useful indicators for a KPI
 Obtain the list of combinations of KPI and indicator which have Kenadll's tau above a certain threshold. This is used to obtain KPI and indicator time series pairs</p>
<h2 id="usage">Usage</h2>
<pre class="editor-colors lang-r"><div class="line"><span class="syntax--text syntax--plain syntax--null-grammar"><span>getUseful_combs(KPI,&nbsp;indicators,&nbsp;threshold&nbsp;=&nbsp;0.23,&nbsp;lags&nbsp;=&nbsp;0:18)</span></span></div></pre>
<h2 id="arguments">Arguments</h2>
<table>
<thead>
<tr>
<th>Argument</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">KPI</code></td>
<td>The time series which we want to find lead time indicators for</td>
</tr>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">indicators</code></td>
<td>The set of indicators which we need to look at</td>
</tr>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">threshold</code></td>
<td>The threshold for kendall's tau above which we consider an indicator useful in modelling the KPI</td>
</tr>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">lags</code></td>
<td>The set of lead times we look at.</td>
</tr>
</tbody>
</table>
<h2 id="value">Value</h2>
<p> A list conating all the set of indicators and lead times which have kendall's tau above the said threshold</p>
<h1 id="getyoy-obtain-year-over-year-transformation"><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">getYoY</code>: Obtain year over year transformation</h1>
<h2 id="description">Description</h2>
<p> Obtain year over year transformation</p>
<h2 id="usage">Usage</h2>
<pre class="editor-colors lang-r"><div class="line"><span class="syntax--text syntax--plain syntax--null-grammar"><span>getYoY(column)</span></span></div></pre>
<h2 id="arguments">Arguments</h2>
<table>
<thead>
<tr>
<th>Argument</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">column</code></td>
<td>The vector/time series</td>
</tr>
</tbody>
</table>
<h2 id="value">Value</h2>
<p> The year over year transformation of the column</p>
<h1 id="l_skewt-calculate-negative-log-likelihood"><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">l_skewT</code>: Calculate negative log likelihood</h1>
<p> Obtain the negative log likelihood for the vector <code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">x</code> for a skew-t distribution</p>
<h2 id="description">Description</h2>
<p> Calculate negative log likelihood
 Obtain the negative log likelihood for the vector <code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">x</code> for a skew-t distribution</p>
<h2 id="usage">Usage</h2>
<pre class="editor-colors lang-r"><div class="line"><span class="syntax--text syntax--plain syntax--null-grammar"><span>l_skewT(x,&nbsp;params)</span></span></div></pre>
<h2 id="arguments">Arguments</h2>
<table>
<thead>
<tr>
<th>Argument</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">x</code></td>
<td>The vector for which we wish to find the negative log likelihood</td>
</tr>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">params</code></td>
<td>The paramters of the skew-t distribution</td>
</tr>
</tbody>
</table>
<h2 id="value">Value</h2>
<p> The negative log likelihood of the vector <code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">x</code> with respect to the skew-t distribution specified by <code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">params</code> </p>
<h1 id="multiplot-place-multiple-plots-together"><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">multiplot</code>: Place multiple plots together</h1>
<p> Utility function to place multiple plots generated by <code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">ggplot</code> on the same page</p>
<h2 id="description">Description</h2>
<p> Place multiple plots together
 Utility function to place multiple plots generated by <code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">ggplot</code> on the same page</p>
<h2 id="usage">Usage</h2>
<pre class="editor-colors lang-r"><div class="line"><span class="syntax--text syntax--plain syntax--null-grammar"><span>multiplot(...,&nbsp;plotlist&nbsp;=&nbsp;NULL,&nbsp;file,&nbsp;cols&nbsp;=&nbsp;1,&nbsp;layout&nbsp;=&nbsp;NULL)</span></span></div></pre>
<h1 id="normalise-normalise-the-time-series"><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">normalise</code>: Normalise the time series</h1>
<p> Normalise the time series using min-max normalisation</p>
<h2 id="description">Description</h2>
<p> Normalise the time series
 Normalise the time series using min-max normalisation</p>
<h2 id="usage">Usage</h2>
<pre class="editor-colors lang-r"><div class="line"><span class="syntax--text syntax--plain syntax--null-grammar"><span>normalise(col)</span></span></div></pre>
<h2 id="arguments">Arguments</h2>
<table>
<thead>
<tr>
<th>Argument</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">col</code></td>
<td>The vector to be normalised</td>
</tr>
</tbody>
</table>
<h2 id="value">Value</h2>
<p> Normalised vector</p>
<h1 id="plotccf_kendall-calculate-optimal-lead-time"><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">plotccf_kendall</code>: Calculate optimal lead time</h1>
<p> Plot the variation of kendall's tau with varying lead times. Useful to identify optimal lead time between KPI and indicator</p>
<h2 id="description">Description</h2>
<p> Calculate optimal lead time
 Plot the variation of kendall's tau with varying lead times. Useful to identify optimal lead time between KPI and indicator</p>
<h2 id="usage">Usage</h2>
<pre class="editor-colors lang-r"><div class="line"><span class="syntax--text syntax--plain syntax--null-grammar"><span>plotccf_kendall(KPI,&nbsp;indicator,&nbsp;max.lag&nbsp;=&nbsp;18,&nbsp;plot&nbsp;=&nbsp;FALSE)</span></span></div></pre>
<h2 id="arguments">Arguments</h2>
<table>
<thead>
<tr>
<th>Argument</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">KPI</code></td>
<td>A vector which we wish to find the optimal lead time</td>
</tr>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">indicator</code></td>
<td>The exogeneous time series vector</td>
</tr>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">max.lag</code></td>
<td>The maximum lead time which we look at while finding the optimal lead time</td>
</tr>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">plot</code></td>
<td>A boolean option which we use to indicate whether plot should be generated or not</td>
</tr>
</tbody>
</table>
<h2 id="value">Value</h2>
<p> The lead time for which we find the kendall's tau value to be maximum</p>
<h1 id="remtrendseasonality-remove-trend-and-seasonality"><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">remTrendSeasonality</code>: Remove trend and seasonality</h1>
<p> Remove the trend and seasonality from the <code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">data</code> vector</p>
<h2 id="description">Description</h2>
<p> Remove trend and seasonality
 Remove the trend and seasonality from the <code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">data</code> vector</p>
<h2 id="usage">Usage</h2>
<pre class="editor-colors lang-r"><div class="line"><span class="syntax--text syntax--plain syntax--null-grammar"><span>remTrendSeasonality(data,&nbsp;s.window&nbsp;=&nbsp;7,&nbsp;t.window&nbsp;=&nbsp;12,&nbsp;seasonality&nbsp;=&nbsp;1,</span></span></div><div class="line"><span class="syntax--text syntax--plain syntax--null-grammar"><span>&nbsp;&nbsp;trend&nbsp;=&nbsp;1)</span></span></div></pre>
<h2 id="arguments">Arguments</h2>
<table>
<thead>
<tr>
<th>Argument</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">data</code></td>
<td>The vector/time series from which the trend and seasonality is to be removed</td>
</tr>
</tbody>
</table>
<h2 id="value">Value</h2>
<p> The data after removing trend and seasonality</p>
<h1 id="rev_transformation-reverse-business-tranformation"><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">rev_transformation</code>: Reverse business tranformation</h1>
<p> Reverse the business transformation to obtain the raw forecast and time series</p>
<h2 id="description">Description</h2>
<p> Reverse business tranformation
 Reverse the business transformation to obtain the raw forecast and time series</p>
<h2 id="usage">Usage</h2>
<pre class="editor-colors lang-r"><div class="line"><span class="syntax--text syntax--plain syntax--null-grammar"><span>rev_transformation(series,&nbsp;trafo&nbsp;=&nbsp;NULL,&nbsp;init_vals)</span></span></div></pre>
<h2 id="arguments">Arguments</h2>
<table>
<thead>
<tr>
<th>Argument</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">series</code></td>
<td>The transformed series</td>
</tr>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">trafo</code></td>
<td>A string which should be one of c(NULL, 'mom','yoy') to specify which transformation to reverse</td>
</tr>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">init_vals</code></td>
<td>The initial values from the raw time series.</td>
</tr>
</tbody>
</table>
<h2 id="value">Value</h2>
<p> The raw time series after reversing the business transformation.</p>
<h1 id="revmom-reverse-month-over-month-transformation"><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">revMoM</code>: Reverse month over month transformation</h1>
<h2 id="description">Description</h2>
<p> Reverse month over month transformation</p>
<h2 id="usage">Usage</h2>
<pre class="editor-colors lang-r"><div class="line"><span class="syntax--text syntax--plain syntax--null-grammar"><span>revMoM(init_val,&nbsp;MoM_vals)</span></span></div></pre>
<h2 id="arguments">Arguments</h2>
<table>
<thead>
<tr>
<th>Argument</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">series</code></td>
<td>The transformed series</td>
</tr>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">init_vals</code></td>
<td>The initial values from the raw time series.</td>
</tr>
</tbody>
</table>
<h2 id="value">Value</h2>
<p> The raw time series after reversing the month over month transformation.</p>
<h1 id="revyoy-reverse-month-over-month-transformation"><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">revYoY</code>: Reverse month over month transformation</h1>
<h2 id="description">Description</h2>
<p> Reverse month over month transformation</p>
<h2 id="usage">Usage</h2>
<pre class="editor-colors lang-r"><div class="line"><span class="syntax--text syntax--plain syntax--null-grammar"><span>revYoY(init_vals,&nbsp;YoY_vals)</span></span></div></pre>
<h2 id="arguments">Arguments</h2>
<table>
<thead>
<tr>
<th>Argument</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">init_vals</code></td>
<td>The initial values from the raw time series.</td>
</tr>
<tr>
<td><code style="font-family: Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace;">series</code></td>
<td>The transformed series</td>
</tr>
</tbody>
</table>
<h2 id="value">Value</h2>
<p> The raw time series after reversing the year over year transformation.</p></body>
</html>

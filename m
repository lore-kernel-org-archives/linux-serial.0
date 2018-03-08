From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH v3 2/4] soc: qcom: Add GENI based QUP Wrapper driver
Date: Thu, 8 Mar 2018 15:41:43 +0100
Message-ID: <20180308144143.GB23266@lst.de>
References: <1519781889-16117-1-git-send-email-kramasub@codeaurora.org>
	<1519781889-16117-3-git-send-email-kramasub@codeaurora.org>
	<152002326567.108663.16836885081217739460@swboyd.mtv.corp.google.com>
	<4ac213a6-081f-72c1-c9c8-6994786285c9@codeaurora.org>
	<152037339742.218381.11498404122038956963@swboyd.mtv.corp.google.com>
	<945b6c00-dde6-6ec7-4577-4cc0d034796b@codeaurora.org>
	<8567be1b-1431-4f1d-cb41-6a7eaa434438@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8567be1b-1431-4f1d-cb41-6a7eaa434438-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Karthik Ramasubramanian <kramasub-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Stephen Boyd <sboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Boyd <swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Girish Mahadevan <girishm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, acourbot-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 08, 2018 at 01:24:45PM +0000, Robin Murphy wrote:
> Implementing dma_map_ops inside a driver for real hardware is almost always 
> the wrong thing to do.

Agreed.  dma_map_ops should be a platform decision based on the bus.

Even our dma_virt_ops basically just works around bad driver layering.

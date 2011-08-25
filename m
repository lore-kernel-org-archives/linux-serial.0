From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 2/4] msm_serial: Add devicetree support
Date: Thu, 25 Aug 2011 13:28:05 +0200
Message-ID: <201108251328.05689.arnd@arndb.de>
References: <1313688345-17699-1-git-send-email-davidb@codeaurora.org> <1313688345-17699-3-git-send-email-davidb@codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1313688345-17699-3-git-send-email-davidb@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: David Brown <davidb@codeaurora.org>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Alan Cox <alan@linux.intel.com>, Grant Likely <grant.likely@secretlab.ca>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

On Thursday 18 August 2011, David Brown wrote:
> Add devicetree support to the msm_serial driver.  Clocks are still
> queried by direct name from the driver until device tree clock support
> is implemented.
> 
> Signed-off-by: David Brown <davidb@codeaurora.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

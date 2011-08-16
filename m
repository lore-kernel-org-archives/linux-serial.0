From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/4] msm_serial: Add devicetree support
Date: Tue, 16 Aug 2011 21:07:08 +0200
Message-ID: <3445697.36l0oAAgCs@wuerfel>
References: <1313190008-7551-1-git-send-email-davidb@codeaurora.org>
	<65679699.l4XXDScc0T@wuerfel>
	<20110816175702.GA27576@huya.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110816175702.GA27576@huya.qualcomm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: David Brown <davidb@codeaurora.org>
Cc: linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Bryan Huntsman <bryanh@codeaurora.org>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Randy Dunlap <rdunlap@xenotime.net>, linux-serial@vger.kernel.org, Daniel Walker <dwalker@fifo99.com>, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Tuesday 16 August 2011 10:57:02 David Brown wrote:
> How about if I just keep it simple for now.  Since there isn't
> actually a driver for the DMA version, this driver will handle both
> UART blocks, so I'll just do the plain thing in the DT.

Sounds good to me.

> In the future, when a DMA-capable driver exists, we can figure out how
> to determine which driver should be used.  At this point, I'm not even
> sure what the correct answer will be, since a given configuration may
> want to use non-DMA for one msm-hsuart device, and the DMA driver for
> another.  It's kind of board/use specific, but beyond just describing
> what the hardware is.

In order to be absolutely future-proof, you could mandate that you always
list two "compatible" values, one for the generic version and one for
the specific implementation (high-speed or low-speed). It's a simple
change from what you have now and it allows to change the drivers to
bind to just the specific name in case you want to handle them separately
in the future, without having to change the device tree files.

	Arnd

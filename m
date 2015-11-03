From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/2] serial: amba-pl011: abstract register accessors
Date: Tue, 3 Nov 2015 16:12:07 +0000
Message-ID: <20151103161206.GA8644@n2100.arm.linux.org.uk>
References: <1446562867-5693-1-git-send-email-timur@codeaurora.org>
 <1446562867-5693-2-git-send-email-timur@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1446562867-5693-2-git-send-email-timur@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Timur Tabi <timur@codeaurora.org>
Cc: peter@hurleysoftware.com, andre.przywara@arm.com, Linus Walleij <linus.walleij@linaro.org>, Andrew.Jackson@arm.com, linux-serial@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>, jslaby@suse.com, jun.nie@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Tue, Nov 03, 2015 at 09:01:07AM -0600, Timur Tabi wrote:
> Finally, note that pl011_putc() is untouched, because that function
> does not have access to the 'uap' object.  A separate mechanism
> is needed to switch accessors in that function.

Thanks for pointing that out... that's a mistake in my patches.  It's
very difficult to see how we could ever support earlyconsole on ZTE
without massively overhauling the earlycon stuff.  I'll undo the
changes there in my series.

Now, as for this patch...

>  	unsigned int (*get_fifosize)(struct amba_device *dev);
> +	u16 (*regreadw)(const void __iomem *addr);
> +	void (*regwritew)(u16 val, void __iomem *addr);
> +	void (*regwriteb)(u8 val, void __iomem *addr);

regwriteb() is used nowhere in this patch.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

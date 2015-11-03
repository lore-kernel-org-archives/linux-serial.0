From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 01/11] tty: amba-pl011: add register accessor functions
Date: Tue, 3 Nov 2015 15:18:58 +0000
Message-ID: <20151103151858.GZ8644@n2100.arm.linux.org.uk>
References: <20151103134349.GV8644@n2100.arm.linux.org.uk>
 <E1ZtcvK-0007Bt-91@rmk-PC.arm.linux.org.uk>
 <5638CA7D.8000404@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <5638CA7D.8000404@codeaurora.org>
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
Cc: Peter Hurley <peter@hurleysoftware.com>, Andre Przywara <andre.przywara@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Andrew.Jackson@arm.com, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jun Nie <jun.nie@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Tue, Nov 03, 2015 at 08:53:49AM -0600, Timur Tabi wrote:
> Russell King wrote:
> >+static unsigned int pl011_read(void __iomem *base, unsigned int reg)
> >+{
> >+	return readw(base + reg);
> >+}
> >+
> >+static void pl011_write(unsigned int val, void __iomem *base, unsigned int reg)
> >+{
> >+	writew(val, base + reg);
> >+}
> 
> This has the same problem as the original, in that it doesn't support the
> SBSA subtype 13.
> 
> I'll post my version soon that addresses this.  Maybe you can consider it as
> a replacement for your patch 1/11.

(I know you've already replied saying to ignore this, but I'm going to
reply to this anyway.)

This is one step in a series of single transformations to the code,
where this one merely replaces readw()/writew() with a local accessor
function.  Adding other changes into this patch would mean that it's
no longer a single transformation.

This "single transformation" theme applies across every patch in this
series, and IMHO shows how the addition of ZTE should have been done
in the first place: a series of single transformations, each one being
fairly obvious and easy to review.

Yes, it produces a bigger patch set, but it means that if there's a
problem with one of the transformations, the whole work doesn't need
to be reverted.  Eg, you'll notice that the more "dodgy" changes (such
as removing register offset entries) are done towards the end of the
series meaning that if there's a problem removing those, either a
single patch can be reverted, or the series can be reverted back to
that point and the benefit of the previous patches isn't lost.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

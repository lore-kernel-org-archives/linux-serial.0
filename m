From: Greg Kroah-Hartman <greg@kroah.com>
Subject: Re: [PATCH] tty: amba-pl011: add support for 32-bit register access
 for earlycon
Date: Thu, 17 Dec 2015 08:27:36 -0800
Message-ID: <20151217162736.GA5897@kroah.com>
References: <1446855503-25881-1-git-send-email-timur@codeaurora.org>
 <20151213060643.GA30667@kroah.com>
 <CAOZdJXVz5Bm2-XBNjoU6uh=i2E0Mq915entU+rz-MqD8F4C=xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAOZdJXVz5Bm2-XBNjoU6uh=i2E0Mq915entU+rz-MqD8F4C=xQ@mail.gmail.com>
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
Cc: Peter Hurley <peter@hurleysoftware.com>, Andre Przywara <andre.przywara@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Andrew Jackson <Andrew.Jackson@arm.com>, cov@codeaurora.org, linux-serial@vger.kernel.org, jslaby@suse.com, Russell King <rmk+kernel@arm.linux.org.uk>, Jun Nie <jun.nie@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Dec 17, 2015 at 09:55:30AM -0600, Timur Tabi wrote:
> On Sun, Dec 13, 2015 at 12:06 AM, Greg Kroah-Hartman <greg@kroah.com> wrote:
> 
> >> Example:
> >>
> >>       earlycon=pl011,mmio32,0x3ced1000
> >>
> >> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> >> ---
> >>
> >> This patch applies on top of Russell's 12-part amba-pl011.c patchset.
> >
> > Which I didn't apply, so can you resend this after he resends his?
> 
> I see that some of Russell's patches are now in tty-next.  Does that
> make them official?

Unless Russell asks me to revert them, they will show up in the next
merge window.

> There was some disagreement about the usage of
> access_32b vs uap->port.iotype for determining whether we need 32-bit
> accessors or not.

There was?  I missed that, please send follow-on patches to resolve the
issue if there is one.

thanks,

greg k-h

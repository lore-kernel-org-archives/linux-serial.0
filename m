From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] tty: amba-pl011: add support for 32-bit register access
 for earlycon
Date: Thu, 17 Dec 2015 09:06:39 -0800
Message-ID: <5672EB9F.805@hurleysoftware.com>
References: <1446855503-25881-1-git-send-email-timur@codeaurora.org>
 <20151213060643.GA30667@kroah.com>
 <CAOZdJXVz5Bm2-XBNjoU6uh=i2E0Mq915entU+rz-MqD8F4C=xQ@mail.gmail.com>
 <20151217162736.GA5897@kroah.com> <5672E73C.20601@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5672E73C.20601@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Timur Tabi <timur@codeaurora.org>, Greg Kroah-Hartman <greg@kroah.com>
Cc: Andre Przywara <andre.przywara@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Andrew Jackson <Andrew.Jackson@arm.com>, cov@codeaurora.org, linux-serial@vger.kernel.org, jslaby@suse.com, Russell King <rmk+kernel@arm.linux.org.uk>, Jun Nie <jun.nie@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On 12/17/2015 08:47 AM, Timur Tabi wrote:
> Greg Kroah-Hartman wrote:
>>> >There was some disagreement about the usage of
>>> >access_32b vs uap->port.iotype for determining whether we need 32-bit
>>> >accessors or not.
>> There was?  I missed that, please send follow-on patches to resolve the
>> issue if there is one.
> 
> I can submit a patch that provides an alternative implementation, but I'm pretty sure Russell won't like it.
> 
> For reference:
> 
> http://www.spinics.net/lists/linux-serial/msg19710.html
> 
> Russell said that UPIO_MEM is supposed to be literally only 8-bit access, but then Peter Hurley posted this:
> 
> http://www.spinics.net/lists/linux-serial/msg19930.html
> 
> which you applied.  So my patch would remove access_32b and use UPIO_MEM32/UPIO_MEM instead.  It would be a little weird having both patches in your tree, I guess.

I think it'll be ok if you just send a patch to use UPIO_MEM32
instead; I think that situation mostly had to do with inertia
and not wanting to rebase a series like that (which I can
appreciate).

The worst that happens is Russell objects, but I think there's a
good case for the simpler UPIO_MEM32 usage, which plays nice
with earlycon.

Regards,
Peter Hurley

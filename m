From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v3 0/*] serial/amba-pl011: Activate TX IRQ passively
Date: Fri, 27 Mar 2015 14:51:34 +0000
Message-ID: <20150327145118.GA1711@e103592.cambridge.arm.com>
References: <1427307746-2811-1-git-send-email-Dave.Martin@arm.com>
 <20150326213014.GA21687@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150326213014.GA21687@kroah.com>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@arm.linux.org.uk>, Jakub =?utf-8?B?S2ljacWEc2tp?= <moorray3@wp.pl>, Andre Przywara <Andre.Przywara@arm.com>, Andrew Jackson <Andrew.Jackson@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, linux-serial@vger.kernel.org, popcorn mix <popcornmix@gmail.com>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 26, 2015 at 10:30:14PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Mar 25, 2015 at 06:22:26PM +0000, Dave Martin wrote:

[...]

> > Take your pick.
> 
> I have no idea what you want me to do here, sorry.
> 
> I need to apply patches to tty-next, I can't do anything against a
> "clean" 4.0-rc5 as your patches are already in tty-next.
> 
> And I can't tell the two series apart here...
> 
> Can you just resend what you want me to apply to tty-next and we can go
> from there?

Apologies, this was a misguided attempt on my part to be helpful.

I will post a v4 shortly, which changes nothing except for rebasing to
tty-next and clarifying the commit message on the second patch.

Note that I haven't seen any feedback from rmk since v1 (which, for
good reasons, he wasn't keen on).

I believe these patches resolve all issues reported so far by other
testers.

Cheers
---Dave

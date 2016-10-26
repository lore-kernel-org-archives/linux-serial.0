From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] tty/serial: at91: fix hardware handshake on Atmel
 platforms
Date: Wed, 26 Oct 2016 17:35:48 +0200
Message-ID: <20161026153548.xxvciigcscrjb5uv@piout.net>
References: <20161025161135.7316-1-richard.genoud@gmail.com>
 <20161025171754.a4lult2ld3gv5a2q@pengutronix.de>
 <f89c29e4-b68f-a8ea-cefb-e70dda6739a0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <f89c29e4-b68f-a8ea-cefb-e70dda6739a0@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Cyrille Pitchen <cyrille.pitchen@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Richard,

On 26/10/2016 at 16:55:02 +0200, Richard Genoud wrote :
> On 25/10/2016 19:17, Uwe Kleine-K=F6nig wrote:
> Quote from the commit message:
> "   Commit 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management when
>     hardware handshake is enabled") actually allowed to enable hardware
>     handshaking.
>     Before, the CRTSCTS flags was silently ignored.
> "
> This wasn't true.
> This was a misunderstanding of the ATMEL_US_USMODE_HWHS flag:
> Commit 1cf6e8fc8341 didn't allowed to enable hardware handshaking, but
> introduced the ATMEL_US_USMODE_HWHS flag.
> And before 1cf6e8fc8341, the CRTSCTS flags wasn't silently ignored, it
> was perfectly respected.
> =


It was not really a misunderstanding, it is a difference in
expectations. There is one topic on which we don't agree and I'm fine
with your solution as long as I don't have to support people with the
failures (hence my ack). My (and Cyrille's) opinion is that CRTSCTS has
to be 100% reliable and this is only possible with assistance from the
hardware. That's why I wanted to report when HW didn't have proper
support to userspace.
On your side you are fine with software handling of RTS and CTS (which
is a feature that worked before our patches). You just have to remember
that at some point because of latencies and the way the IPs are clocked,
this will fail and you'll start losing bytes.

Again, I'm fine with that but I won't handle people complaining about it
:)


-- =

Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

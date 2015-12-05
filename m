From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH LINUX v3 09/10] tty: xuartps: Only handle RX IRQs when RX
 is enabled
Date: Sat, 5 Dec 2015 14:19:12 -0800
Message-ID: <20151205221912.GP4900@xsjsorenbubuntu>
References: <1448161172-19717-1-git-send-email-soren.brinkmann@xilinx.com>
 <1448161172-19717-10-git-send-email-soren.brinkmann@xilinx.com>
 <56632231.6000000@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56632231.6000000@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Sat, 2015-12-05 at 12:43PM -0500, Peter Hurley wrote:
> On 11/21/2015 09:59 PM, Soren Brinkmann wrote:
> > Ignore RX-related interrupts if RX is not enabled.
>=20
> This doesn't look like a safe approach; fast-forward a couple of year=
s and
> some is trying to add some feature but can't figure out why no data i=
s
> arriving...
>=20
> What is this trying to solve?

I definitely saw two kinds of lock ups. One was on the TX side, that th=
e
system tried to print with the transmitter disabled.

The other on the RX side. I don't recall the details, but the system wa=
s
stuck in some RX-related function waiting for data while the receiver
was disabled. I think my explanation was that some IRQ condition become=
s
true and is dispatched to the RX handler even though the receiver isn't
enabled.
I guess a better way for solving this would be to disable the IRQs that
call the RX handler when the receiver is disabled.

	S=C3=B6ren

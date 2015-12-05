From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH LINUX v3 05/10] tty: xuartps: Improve startup function
Date: Sat, 5 Dec 2015 13:47:09 -0800
Message-ID: <20151205214709.GM4900@xsjsorenbubuntu>
References: <1448161172-19717-1-git-send-email-soren.brinkmann@xilinx.com>
 <1448161172-19717-6-git-send-email-soren.brinkmann@xilinx.com>
 <56631D1E.8050406@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56631D1E.8050406@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sat, 2015-12-05 at 12:21PM -0500, Peter Hurley wrote:
> On 11/21/2015 09:59 PM, Soren Brinkmann wrote:
> > The startup function is supposed to initialize the UART for receivi=
ng.
> > Hence, don't enable the TX part. Also, protect HW accesses with the=
 port
> > lock.
>=20
> Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
>=20
> NB: the request_irq() should be _after_ h/w programming, otherwise an
> interrupt could be triggered and in-progress before the h/w has been
> setup.

Thanks for pointing that out. I'll patch that.

	S=C3=B6ren

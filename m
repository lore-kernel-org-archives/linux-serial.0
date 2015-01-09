From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/5] tty/serial: at91: use correct type for
 dma_sync_*_for_cpu() and dma_sync_*_for_device()
Date: Fri, 9 Jan 2015 14:19:27 -0800
Message-ID: <20150109221927.GA19100@kroah.com>
References: <cover.1418131298.git.cyrille.pitchen@atmel.com>
 <830a2b33ab0226405dc310c8a6d43731bf4ca8f9.1418131298.git.cyrille.pitchen@atmel.com>
 <54AFF037.1000004@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54AFF037.1000004@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Cyrille Pitchen <cyrille.pitchen@atmel.com>, wenyou.yang@atmel.com, ludovic.desroches@atmel.com, leilei.zhao@atmel.com, voice.shen@atmel.com, josh.wu@atmel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Fri, Jan 09, 2015 at 04:13:59PM +0100, Nicolas Ferre wrote:
> Le 09/12/2014 14:31, Cyrille Pitchen a =E9crit :
> > dma_sync_*_for_cpu() and dma_sync_*_for_device() use 'enum dma_data=
_direction',
> > not 'enum dma_transfer_direction'
> >=20
> > Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
>=20
> Sure:
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>=20
> Here it's difficult to add a "stable" tag as the error was introduced=
 by
> several different patches.

So that means it's not ok for older kernels?  That doesn't make sense..=
=2E

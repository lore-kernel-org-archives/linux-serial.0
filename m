From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/1] serial: imx: Add rs485 support to imx thanks to rs485
 functions in serial_core
Date: Wed, 11 Feb 2015 12:46:40 -0200
Message-ID: <CAOMZO5DnNw28g1c9r3Y+Ms-W47UCLyFF87pAz0W9yxAxDyc-xg@mail.gmail.com>
References: <1423664549-29002-1-git-send-email-a.bouin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423664549-29002-1-git-send-email-a.bouin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aurelien BOUIN <a.bouin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, sascha@saschahauer.de, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Aurelien,

On Wed, Feb 11, 2015 at 12:22 PM, Aurelien BOUIN <a.bouin@gmail.com> wrote:
> This is a patch to add rs485 support with imx freescale processor
> It allows to set the transmit pin used in the structure padding (rs485.padding[0])
> This patch also solved various issues detected by checkpatch.pl

Thanks for the patch.

Please split it in two patches: one that adds RS485 support and one
that fixes the checkpatch warnings.

Thanks,

Fabio Estevam

From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] tty:serial:imx: use spin_lock instead of
 spin_lock_irqsave in isr
Date: Tue, 28 Aug 2018 16:36:38 +0800
Message-ID: <CAGsJ_4yLruLKnKc6kpr1JZ8BSSS4wAyvxeGm6A+S7-rLAZAVmg@mail.gmail.com>
References: <20180827144904.17226-1-hangdianqj@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180827144904.17226-1-hangdianqj@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hangdianqj@163.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.com, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

jun qian <hangdianqj@163.com> =E4=BA=8E2018=E5=B9=B48=E6=9C=8827=E6=97=A5=
=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8810:49=E5=86=99=E9=81=93=EF=BC=9A
>
> Before the program enters the uart ISR, the local interrupt has been
> disabled by the system, so it's not appropriate to use spin_lock_irqsave
> interface in the ISR.
>
> Signed-off-by: jun qian <hangdianqj@163.com>

many discussions have been done with jun in wechat regarding this patch. an=
d

Reviewed-by: Barry Song <21cnbao@gmail.com>

> ---
> =C2=A0drivers/tty/serial/imx.c | 21 ++++++++-------------
> =C2=A01 file changed, 8 insertions(+), 13 deletions(-)
>

From: =?UTF-8?Q?Am=C3=A9rico_Wang?= <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH] cris: lower the printk level in cris serial driver
Date: Thu, 1 Sep 2011 15:16:00 +0800
Message-ID: <CAM_iQpULfmXV96AB5L4K78rLfom+9F=sb6FgGSaOywtOzPt6Pg@mail.gmail.com>
References: <1314857640-6623-1-git-send-email-xiyou.wangcong@gmail.com>
	<CAMuHMdWSm2bQQpdM1OM=6+17CeNikn9RYm_BpFmEV7jD4sAPig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWSm2bQQpdM1OM=6+17CeNikn9RYm_BpFmEV7jD4sAPig@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Alan Cox <alan@linux.intel.com>, linux-cris-kernel@axis.com, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Sep 1, 2011 at 2:35 PM, Geert Uytterhoeven <geert@linux-m68k.or=
g> wrote:
> On Thu, Sep 1, 2011 at 08:14, WANG Cong <xiyou.wangcong@gmail.com> wr=
ote:
>> KERN_CRIT is too high, replace those KERN_CRIT with KERN_ERR or KERN=
_INFO.
>>
>> Cc: Mikael Starvik <starvik@axis.com>
>> Cc: Jesper Nilsson <jesper.nilsson@axis.com>
>> Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>
>>
>> ---
>> diff --git a/drivers/tty/serial/crisv10.c b/drivers/tty/serial/crisv=
10.c
>> index 225123b..77ba4ed 100644
>> --- a/drivers/tty/serial/crisv10.c
>> +++ b/drivers/tty/serial/crisv10.c
>> @@ -1788,7 +1788,7 @@ static unsigned int handle_descr_data(struct e=
100_serial *info,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct etrax_recv_buffer *buffer =3D phys=
_to_virt(descr->buf) - sizeof *buffer;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (info->recv_cnt + recvl > 65536) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_CRIT
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_INFO
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 "%s: Too much pending incoming serial data! Dropping %u bytes.\=
n", __func__, recvl);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> I think dropped data warrants KERN_WARN.
>

Yeah, agreed! I will update this patch shortly.

Thanks.

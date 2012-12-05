From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] synclink fix ldisc buffer argument
Date: Wed, 05 Dec 2012 09:57:34 +0800
Message-ID: <50BEAA0E.9000603@asianux.com>
References: <50B6E751.9000000@asianux.com> <20121129051335.GA4375@kroah.com> <50B6F967.3050000@asianux.com> <20121129183207.GA4688@kroah.com> <50B81F76.8020508@asianux.com> <50B8DDAC.8070901@microgate.com> <50B90D0D.9040401@microgate.com> <20121202151332.3b6a6504@pyramind.ukuu.org.uk> <F6B8A325-7DBF-4623-B16C-CDC5642EFD16@microgate.com> <20121202181057.097012c6@pyramind.ukuu.org.uk> <989CB961-79F8-479B-B16C-41358A60AC94@microgate.com> <50BC0C84.4060802@asianux.com> <50BCCD4C.8050209@microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:37996 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281Ab2LEB4l (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Dec 2012 20:56:41 -0500
In-Reply-To: <50BCCD4C.8050209@microgate.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Paul Fulghum <paulkf@microgate.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org

=E4=BA=8E 2012=E5=B9=B412=E6=9C=8804=E6=97=A5 00:03, Paul Fulghum =E5=86=
=99=E9=81=93:
> On 12/2/2012 8:20 PM, Chen Gang wrote:
>> pardon (I am just learning)
>>   does 65535 mean HDLC_MAX_FRAME_SIZE ?
>>   why do we need info->max_frame_size >=3D 4096 ?
>> in drivers/tty/synclink_gt.c:
>> 3550         if (info->max_frame_size < 4096)
>> 3551                 info->max_frame_size =3D 4096;
>> 3552         else if (info->max_frame_size > 65535)
>> 3553                 info->max_frame_size =3D 65535;
>> 3554
>>  ...
>> 3603                 info->max_frame_size =3D 4096;
>=20
> The hardware can send and receive HDLC frames up to
> 64K in size. The driver defaults to 4K max frame size
> to save buffer space for the common case
> (line 3603 in alloc_dev()).
>=20
> The module parameter max_frame_size can override the default
> in add_device() (lines 3550-3554 are from add_device()
> range checking the module parameter)
>=20

  thank you.

  sorry for reply late (yesterday, I have an annual leave for personal =
things, and not connect net).

by the way:
  does it also need check the length in function rx_get_buf ?=20
  (it seems not, but I am not quite sure, can you give a confirm ?)

4779 /*
4780  * pass receive buffer (RAW synchronous mode) to tty layer
4781  * return true if buffer available, otherwise false
4782  */
4783 static bool rx_get_buf(struct slgt_info *info)
4784 {
4785         unsigned int i =3D info->rbuf_current;
4786         unsigned int count;
4787=20
4788         if (!desc_complete(info->rbufs[i]))
4789                 return false;
4790         count =3D desc_count(info->rbufs[i]);
4791         switch(info->params.mode) {
4792         case MGSL_MODE_MONOSYNC:
4793         case MGSL_MODE_BISYNC:
4794         case MGSL_MODE_XSYNC:
4795                 /* ignore residue in byte synchronous modes */
4796                 if (desc_residue(info->rbufs[i]))
4797                         count--;
4798                 break;
4799         }
4800         DBGDATA(info, info->rbufs[i].buf, count, "rx");
4801         DBGINFO(("rx_get_buf size=3D%d\n", count));
4802         if (count)
4803                 ldisc_receive_buf(info->port.tty, info->rbufs[i].b=
uf,
4804                                   info->flag_buf, count);
4805         free_rbufs(info, i, i);
4806         return true;
4807 }




--=20
Chen Gang

Asianux Corporation
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

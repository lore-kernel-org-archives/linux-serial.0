From: =?UTF-8?B?RXJpYyBCw6luYXJk?= <eric@eukrea.com>
Subject: Re: [PATCH 2/2] n_gsm: add a documentation
Date: Tue, 08 Mar 2011 01:27:28 +0100
Message-ID: <4D7577F0.2030901@eukrea.com>
References: <1299543872-14580-1-git-send-email-eric@eukrea.com> <1299543872-14580-2-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:42685 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752323Ab1CHA1g (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 7 Mar 2011 19:27:36 -0500
In-Reply-To: <1299543872-14580-2-git-send-email-eric@eukrea.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk

Hi,

On 08/03/2011 01:24, Eric B=C3=A9nard wrote:
> +6- first close all virtual ports before closing the physical port.
> +

here is what I get when closing the physical serial port and when a vir=
tual=20
port is still open :

[ 1051.950000] ------------[ cut here ]------------
[ 1051.950000] WARNING: at drivers/tty/tty_mutex.c:31 tty_lock+0x30/0x5=
0()
[ 1051.960000] Modules linked in:
[ 1051.960000] [<c0029478>] (unwind_backtrace+0x0/0xe4) from [<c0034f30=
>]=20
(warn_slowpath_common+0x4c/0x64)
[ 1051.970000] [<c0034f30>] (warn_slowpath_common+0x4c/0x64) from [<c00=
34f60>]=20
(warn_slowpath_null+0x18/0x1c)
[ 1051.980000] [<c0034f60>] (warn_slowpath_null+0x18/0x1c) from [<c0315=
50c>]=20
(tty_lock+0x30/0x50)
[ 1051.990000] [<c031550c>] (tty_lock+0x30/0x50) from [<c01af5b0>]=20
(__tty_hangup+0x78/0x47c)
[ 1052.000000] [<c01af5b0>] (__tty_hangup+0x78/0x47c) from [<c01ba69c>]=
=20
(gsm_cleanup_mux+0x198/0x214)
[ 1052.010000] [<c01ba69c>] (gsm_cleanup_mux+0x198/0x214) from [<c01baa=
f4>]=20
(gsmld_close+0x28/0x4c)
[ 1052.020000] [<c01baaf4>] (gsmld_close+0x28/0x4c) from [<c01b5974>]=20
(tty_ldisc_close+0x58/0x64)
[ 1052.030000] [<c01b5974>] (tty_ldisc_close+0x58/0x64) from [<c01b5b48=
>]=20
(tty_ldisc_release+0x38/0x70)
[ 1052.040000] [<c01b5b48>] (tty_ldisc_release+0x38/0x70) from [<c01b0e=
2c>]=20
(tty_release+0x41c/0x480)
[ 1052.050000] [<c01b0e2c>] (tty_release+0x41c/0x480) from [<c009667c>]=
=20
(fput+0x108/0x200)
[ 1052.060000] [<c009667c>] (fput+0x108/0x200) from [<c00939c8>]=20
(filp_close+0x60/0x6c)
[ 1052.070000] [<c00939c8>] (filp_close+0x60/0x6c) from [<c0036eb8>]=20
(put_files_struct+0x80/0xdc)
[ 1052.080000] [<c0036eb8>] (put_files_struct+0x80/0xdc) from [<c003850=
0>]=20
(do_exit+0x1b8/0x6bc)
[ 1052.080000] [<c0038500>] (do_exit+0x1b8/0x6bc) from [<c0038ac4>]=20
(do_group_exit+0xc0/0xf4)
[ 1052.090000] [<c0038ac4>] (do_group_exit+0xc0/0xf4) from [<c0044460>]=
=20
(get_signal_to_deliver+0x3ac/0x40c)
[ 1052.100000] [<c0044460>] (get_signal_to_deliver+0x3ac/0x40c) from=20
[<c0027190>] (do_signal+0x68/0x614)
[ 1052.110000] [<c0027190>] (do_signal+0x68/0x614) from [<c0027754>]=20
(do_notify_resume+0x18/0x60)
[ 1052.120000] [<c0027754>] (do_notify_resume+0x18/0x60) from [<c0024f9=
4>]=20
(work_pending+0x24/0x28)
[ 1052.130000] ---[ end trace ac06c34c1914deef ]---


Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

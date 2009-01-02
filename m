From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH 09/75] Per-mount allocated_ptys
Date: Fri, 2 Jan 2009 20:47:17 +0100
Message-ID: <20090102194717.GA2532@rere.qmqm.pl>
References: <20090102133822.13472.53912.stgit@localhost.localdomain> <20090102134117.13472.80831.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from rere.qmqm.pl ([89.167.52.164]:58714 "EHLO rere.qmqm.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758545AbZABTxq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 14:53:46 -0500
Content-Disposition: inline
In-Reply-To: <20090102134117.13472.80831.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@osdl.org, linux-serial@vger.kernel.org, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

On Fri, Jan 02, 2009 at 01:41:21PM +0000, Alan Cox wrote:
> To enable multiple mounts of devpts, 'allocated_ptys' must be a per-m=
ount
> variable rather than a global variable.  Move 'allocated_ptys' into t=
he
> super_block's s_fs_info.
[...]=20
>  extern int pty_limit;			/* Config limit on Unix98 ptys */
> -static DEFINE_IDA(allocated_ptys);
>  static DEFINE_MUTEX(allocated_ptys_lock);
> =20
>  static struct vfsmount *devpts_mnt;
> @@ -55,6 +54,15 @@ static const match_table_t tokens =3D {
>  	{Opt_err, NULL}
>  };
> =20
> +struct pts_fs_info {
> +	struct ida allocated_ptys;
> +};
[...]

Shouldn't allocated_ptys_lock be included with allocated_ptys in
pts_fs_info? This probably doesn't matter unless machine is doing
a lot of PTY creation/removal, but is more correct IMO.

Best Regards,
Micha=B3 Miros=B3aw
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

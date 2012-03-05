From: Tilman Schmidt <tilman@imap.cc>
Subject: Re: [PATCH 67/68] TTY: isdn/gigaset, do not set tty->driver_data
 to NULL
Date: Mon, 05 Mar 2012 18:05:52 +0100
Message-ID: <4F54F270.8030108@imap.cc>
References: <1330955575-26641-1-git-send-email-jslaby@suse.cz> <1330955575-26641-68-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1330955575-26641-68-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: gregkh@linuxfoundation.org, alan@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com, Hansjoerg Lipp <hjlipp@web.de>, gigaset307x-common@lists.sourceforge.net
List-Id: linux-serial@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am 05.03.2012 14:52, schrieb Jiri Slaby:
> Close the window in open where driver_data is reset to NULL on each
> open. It could cause other processes to get invalid retval from the
> tty->ops operations because of the checks all over the code.
>=20
> With this change we may do other cleanups. Now, the only valid check
> for tty->driver_data !=3D NULL is in close. This can happen only if o=
pen
> fails at gigaset_get_cs_by_tty or try_module_get. The rest of checks
> in various tty->ops->* are invalid as driver_data cannot be NULL
> there. The same holds for cs->open_count. So remove them.

Thanks for that nice cleanup. It's most welcome.
Just one question and a small nit:

> --- a/drivers/isdn/gigaset/interface.c
> +++ b/drivers/isdn/gigaset/interface.c
[...]
> @@ -178,12 +176,11 @@ static int if_open(struct tty_struct *tty, stru=
ct file *filp)
> =20
>  static void if_close(struct tty_struct *tty, struct file *filp)
>  {
> -	struct cardstate *cs;
> +	struct cardstate *cs =3D tty->driver_data;
>  	unsigned long flags;
> =20
> -	cs =3D (struct cardstate *) tty->driver_data;
> -	if (!cs) {
> -		pr_err("%s: no cardstate\n", __func__);
> +	if (!cs) { /* happens if we didn't find cs in open */
> +		printk(KERN_DEBUG "%s: no cardstate\n", __func__);
>  		return;
>  	}
> =20

Why are you downgrading the error message from KERN_ERR to KERN_DEBUG
here? I would think that condition would warrant a message with
KERN_ERR severity.
Also, the driver does KERN_DEBUG output uniformly through the gig_dbg
macro, so if you are sure it should be turned into a debug message
then please write it as

	gig_dbg(DEBUG_IF, "%s: no cardstate", __func__);

like four lines later.

Thanks,
Tilman

- --=20
Tilman Schmidt                    E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk9U8nAACgkQQ3+did9BuFsaiwCeKiL8hghkVcjstG5azxYoIXOK
Yl0Anj2FWsaiE4zx3ioVvCo6xgFVKBTk
=3Di3+X
-----END PGP SIGNATURE-----

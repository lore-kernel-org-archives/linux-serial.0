From: =?ISO-8859-1?Q?S=F8ren?= holm <sgh@sgh.dk>
Subject: Re: About changing Line Discipline  from Kernel
Date: Wed, 22 Feb 2012 09:22:36 +0100
Message-ID: <1454871.D1ceTDIupK@koontz>
References: <4F4493AC.5010405@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cpe.ge-0-2-0-951.faaqnqu1.customer.tele.dk ([93.167.193.22]:52369
	"EHLO mail.mikrofyn.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148Ab2BVIhw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 22 Feb 2012 03:37:52 -0500
In-Reply-To: <4F4493AC.5010405@codeaurora.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mayank Rana <mrana@codeaurora.org>
Cc: linux-serial@vger.kernel.org

Onsdag den 22. februar 2012 12:35:16 skrev Mayank Rana:
>=20
> I have few queries related to using Line Discipline.
>=20
> 1. I understand that line discipline can be changed from user space
> application by opening the device and doing ioctl with required Line
> Discipline ID. Is it possible to do the same from kernel module who
> would be communicating with that line discipline ?
>=20
> 2. Is it way to set default line discipline for particular tty device
> to required Line Discipline instead of N_TTY one ?
>=20
> Appreciate your help on this.

I've earlier done something like this :


        /* Attach line discipline to the uctrl tty */
        set_fs(get_ds());
        ret =3D put_user(N_PS3D, &ldiscNum);
        if (ret !=3D 0) {
                PSDEBUG(debuglevel, "Leaving, EFAULT\n");
                return -EFAULT;
        } else {
                set_fs(KERNEL_DS);
                ret =3D uctrl_file->f_op->unlocked_ioctl(uctrl_file, TI=
OCSETD, (unsigned long)&ldiscNum);

                /*
                 * Decrement use count since setting the line desciplin=
e triggers a call to 'n_ps3d_tty_open'
                 * which increments the use count making it impossible =
to only the module without --force
                 */
                module_put(THIS_MODULE);

                if (ret < 0) {
                        PSKERR(debuglevel, "failed with n_tty_ioctl()\n=
");
                        return -EFAULT;
                }
        }
        set_fs(old_fs);



--=20
S=F8ren Holm
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

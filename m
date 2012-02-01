From: ttuttle <ttuttle-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 3/4] qcserial: remove unused "debug" parameter
Date: Wed, 1 Feb 2012 16:13:39 -0500
Message-ID: <CADyrwZSNdmx6Py-vhVhwngCK9Lf+pXjHPmvdW6oaX9Uz66sf6g@mail.gmail.com>
References: <20120201210735.GC16802@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120201210735.GC16802-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

=2E..ignore this patch.  debug is not unused -- the dbg macro reference=
s
it, but is defined elsewhere.

Sorry for the noise; turns out I was not actually building my modified =
tree. >.<

On Wed, Feb 1, 2012 at 16:07, Thomas Tuttle <ttuttle-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrot=
e:
> Signed-off-by: Thomas Tuttle <ttuttle-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
> =C2=A0drivers/usb/serial/qcserial.c | =C2=A0 =C2=A05 -----
> =C2=A01 files changed, 0 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcser=
ial.c
> index 5a817d6..0f549c6 100644
> --- a/drivers/usb/serial/qcserial.c
> +++ b/drivers/usb/serial/qcserial.c
> @@ -22,8 +22,6 @@
> =C2=A0#define DRIVER_AUTHOR "Qualcomm Inc"
> =C2=A0#define DRIVER_DESC "Qualcomm USB Serial driver"
>
> -static bool debug;
> -
> =C2=A0static const struct usb_device_id id_table[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{USB_DEVICE(0x05c6, 0x9211)}, =C2=A0 /* Ac=
er Gobi QDL device */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{USB_DEVICE(0x05c6, 0x9212)}, =C2=A0 /* Ac=
er Gobi Modem Device */
> @@ -298,6 +296,3 @@ module_exit(qcexit);
> =C2=A0MODULE_AUTHOR(DRIVER_AUTHOR);
> =C2=A0MODULE_DESCRIPTION(DRIVER_DESC);
> =C2=A0MODULE_LICENSE("GPL v2");
> -
> -module_param(debug, bool, S_IRUGO | S_IWUSR);
> -MODULE_PARM_DESC(debug, "Debug enabled or not");
> --
> 1.7.7.3
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

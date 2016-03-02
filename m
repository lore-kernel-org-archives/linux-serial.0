From: Carlo Caione <carlo@caione.org>
Subject: Re: [PATCH v3] tty: serial: meson: Implement earlycon support
Date: Wed, 2 Mar 2016 09:40:01 +0100
Message-ID: <CAOQ7t2a7-5qRDXZDGDpOCiwczHy-MmQcG0LH9GMKLMaXs98Sig@mail.gmail.com>
References: <1456886949-26503-1-git-send-email-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456886949-26503-1-git-send-email-afaerber@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc: linux-meson <linux-meson@googlegroups.com>, Peter Hurley <peter@hurleysoftware.com>, Nicolas Saenz Julienne <nicolassaenzj@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Carlo Caione <carlo@caione.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, "moderated list:ARM/Amlogic Meson SoC support" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 2, 2016 at 3:49 AM, Andreas F=C3=A4rber <afaerber@suse.de> =
wrote:
> Split off the bulk of the existing meson_serial_console_write()
> implementation into meson_serial_port_write() for implementing
> meson_serial_early_console_write().
>
> Use "meson" as the earlycon driver name, courtesy of Nicolas.
>
> Signed-off-by: Nicolas Saenz Julienne <nicolassaenzj@gmail.com>
> Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>

Acked-by: Carlo Caione <carlo@endlessm.com>

Thanks,

--=20
Carlo Caione

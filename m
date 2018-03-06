From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 3/3] tty: st-asc: Update tty alias
Date: Tue, 6 Mar 2018 07:29:15 -0600
Message-ID: <CAL_JsqJv-FV4T8=+py2EEr4kipnQikJPhDKkDdvkAab2QTgBzg@mail.gmail.com>
References: <1520323650-11030-1-git-send-email-patrice.chotard@st.com> <1520323650-11030-4-git-send-email-patrice.chotard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1520323650-11030-4-git-send-email-patrice.chotard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrice Chotard <patrice.chotard@st.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 6, 2018 at 2:07 AM,  <patrice.chotard@st.com> wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
>
> Since dtc v1.4.6-9-gaadd0b65c987, aliases property name
> must include only lowercase and '-'.
>
> After having updated all STi boards serial aliases from "ttyASN"
> to "serialN", st-asc driver need to be updated accordingly as tty
> aliases id is retrieved using of_alias_get_id(np, ASC_SERIAL_NAME);

Again, changing the tty name breaks userspace. You can't do that.

You need to do something like this:

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index c763253514e9..5f9f01fac6dd 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -782,7 +782,9 @@ static struct asc_port *asc_of_get_asc_port(struct
platform_device *pdev)
        if (!np)
                return NULL;

-       id = of_alias_get_id(np, ASC_SERIAL_NAME);
+       id = of_alias_get_id(np, "serial");
+       if (id < 0)
+               id = of_alias_get_id(np, ASC_SERIAL_NAME);

        if (id < 0)
                id = 0;

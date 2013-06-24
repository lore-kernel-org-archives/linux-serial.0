From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5] serial:st-asc: Add ST ASC driver.
Date: Mon, 24 Jun 2013 16:38:13 -0700
Message-ID: <20130624233813.GA4108@kroah.com>
References: <1372058503-30505-1-git-send-email-srinivas.kandagatla@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1372058503-30505-1-git-send-email-srinivas.kandagatla@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Jiri Slaby <jslaby@suse.cz>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Stephen Gallimore <stephen.gallimore@st.com>, Stuart Menefy <stuart.menefy@st.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-serial@vger.kernel.org

On Mon, Jun 24, 2013 at 08:21:43AM +0100, Srinivas KANDAGATLA wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
>=20
> This patch adds support to ASC (asynchronous serial controller)
> driver, which is basically a standard serial driver. This IP is commo=
n
> across all the ST parts for settop box platforms.
>=20
> ASC is embedded in ST COMMS IP block. It supports Rx & Tx functionali=
ty.
> It support all industry standard baud rates.
>=20
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> CC: Stephen Gallimore <stephen.gallimore@st.com>
> CC: Stuart Menefy <stuart.menefy@st.com>
> CC: Arnd Bergmann <arnd@arndb.de>
> ---
> Hi Greg,
>=20
> This patch is the part of the driver support for Stixxxx SOCs.
> This patch undergone 3-4 cycles of review in arm-kernel mailing list.
> As Arnd prefered to take only SOC support patches via arm-soc, Am=20
> sending this patch seperately.
>=20
> If its not too late, can you consider this patch for 3.11 via tty tre=
e?

I would have taken it, but it breaks the build on my machine:

drivers/tty/serial/st-asc.c: In function =E2=80=98asc_serial_resume=E2=80=
=99:
drivers/tty/serial/st-asc.c:774:15: error: =E2=80=98struct device=E2=80=
=99 has no member named =E2=80=98pins=E2=80=99
drivers/tty/serial/st-asc.c:775:3: error: implicit declaration of funct=
ion =E2=80=98pinctrl_select_state=E2=80=99 [-Werror=3Dimplicit-function=
-declaration]
drivers/tty/serial/st-asc.c:775:37: error: =E2=80=98struct device=E2=80=
=99 has no member named =E2=80=98pins=E2=80=99
drivers/tty/serial/st-asc.c:776:16: error: =E2=80=98struct device=E2=80=
=99 has no member named =E2=80=98pins=E2=80=99

Please test your patches out on a "normal" Linux system.

Please feel free to resend this after 3.11-rc1 is out, for inclusion in
3.12, after you have fixed the build problems.

greg k-h

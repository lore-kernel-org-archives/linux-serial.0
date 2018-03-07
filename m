From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 3/3] tty: st-asc: Update tty alias
Date: Wed, 7 Mar 2018 10:13:41 -0600
Message-ID: <CAL_JsqL5bO1MpHvATfRAGi9=cHzBf3n6AVD5=JVfAzt0DnGfqw@mail.gmail.com>
References: <1520412597-30545-1-git-send-email-patrice.chotard@st.com> <1520412597-30545-4-git-send-email-patrice.chotard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1520412597-30545-4-git-send-email-patrice.chotard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrice Chotard <patrice.chotard@st.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 7, 2018 at 2:49 AM,  <patrice.chotard@st.com> wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
>
> Since dtc v1.4.6-9-gaadd0b65c987, aliases property name
> must include only lowercase and '-'.
>
> After having updated all STi boards serial aliases from "ttyASN"
> to "serialN", st-asc driver need to be updated accordingly as tty
> aliases id is retrieved using of_alias_get_id().
>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> ---
> v3: _ update st-asc driver with "serial" alias prefix and keep "ttyAS" in second choice
> v2: _ update st-asc driver with "serial" alias prefix
>
>  drivers/tty/serial/st-asc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>

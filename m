From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/3] printk: make preferred_console local static bool
Date: Mon, 25 Jan 2016 05:23:25 -0800
Message-ID: <1453728205.28952.62.camel@perches.com>
References: <1453722324-22407-1-git-send-email-aleksey.makarov@linaro.org>
	 <1453722324-22407-2-git-send-email-aleksey.makarov@linaro.org>
	 <1453725901.28952.53.camel@perches.com> <56A61A6F.10409@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <56A61A6F.10409@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Graeme Gregory <graeme.gregory@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>
List-Id: linux-serial@vger.kernel.org

On Mon, 2016-01-25 at 18:51 +0600, Aleksey Makarov wrote:
>=20
> On 25.01.2016 18:45, Joe Perches wrote:
> > On Mon, 2016-01-25 at 17:45 +0600, Aleksey Makarov wrote:
> > > The variable preferred_console is used only inside register_conso=
le()
> > > and it's semantics is boolean.=A0=A0Make it clear.
> >=20
> > This loses the index of the preferred console.
> > I'm not sure this is better.
>=20
> That index is not used anywhere.=A0=A0I believe the patch makes thing=
s clear.

Well, with this change the name and its use
is a bit misleading. =A0Maybe changing it to
something like use_selected_console is better.

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 3/3] misc: Add w2sg0004 gps receiver driver
Date: Fri, 16 Oct 2015 21:06:14 +0200
Message-ID: <3951119.loGSTxYIZb@wuerfel>
References: <cover.1445018912.git.hns@goldelico.com> <c53ab7a3ca68f8b9f802c1ea799d72e1cb04a1eb.1445018913.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <c53ab7a3ca68f8b9f802c1ea799d72e1cb04a1eb.1445018913.git.hns@goldelico.com>
Sender: linux-doc-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>, Sergei Zviagintsev <sergei@s15v.net>, Peter Hurley <peter@hurleysoftware.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Sebastian Reichel <sre@kernel.org>, NeilBrown <neil@brown.name>, Grant Likely <grant.likely@linaro.org>, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Marek Belisko <marek@goldelico.com>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Friday 16 October 2015 20:08:35 H. Nikolaus Schaller wrote:
> +
> +static int w2sg_data_probe(struct platform_device *pdev)
> +{
> +       struct w2sg_pdata *pdata = dev_get_platdata(&pdev->dev);
> +       struct w2sg_data *data;
> +       struct rfkill *rf_kill;
> +       int err;
> +
> +       pr_debug("%s()\n", __func__);
> +
> +       if (pdev->dev.of_node) {
> +               struct device *dev = &pdev->dev;
> +               enum of_gpio_flags flags;
> +
> +               pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +               if (!pdata)
> 

Why is this a platform_device and not a serio_device?

	Arnd

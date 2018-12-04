From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 07/14] clock: milbeaut: Add Milbeaut M10V clock control
Date: Tue, 04 Dec 2018 10:15:41 -0800
Message-ID: <154394734173.88331.18352656286616172689@swboyd.mtv.corp.google.com>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-8-git-send-email-sugaya.taichi@socionext.com>
 <154356669840.88331.4455990896653868594@swboyd.mtv.corp.google.com>
 <298cd5a5-66cf-0936-405e-59bcc7c396ed@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <298cd5a5-66cf-0936-405e-59bcc7c396ed@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Sugaya, Taichi" <sugaya.taichi@socionext.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Russell King <linux@armlinux.org.uk>, Jiri Slaby <jslaby@suse.com>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>
List-Id: linux-serial@vger.kernel.org

Quoting Sugaya, Taichi (2018-12-04 00:26:16)
> On 2018/11/30 17:31, Stephen Boyd wrote:
> > Quoting Sugaya Taichi (2018-11-18 17:01:12)
> >> +void __init m10v_clk_mux_setup(struct device_node *node)
> >> +{
> >> +       const char *clk_name =3D node->name;
> >> +       struct clk_init_data init;
> >> +       const char **parent_names;
> >> +       struct m10v_mux *mcm;
> >> +       struct clk *clk;
> >> +       int i, parents;
> >> +
> >> +       if (!m10v_clk_iomap())
> >> +               return;
> >> +
> >> +       of_property_read_string(node, "clock-output-names", &clk_name);
> >> +
> >> +       parents =3D of_clk_get_parent_count(node);
> >> +       if (parents < 2) {
> >> +               pr_err("%s: not a mux\n", clk_name);
> > =

> > How is this possible?
> =

> When the node has more than 1 clks...
> Or I am misunderstanding your question?

This looks like code that's checking DT for correctness. We don't
typically do that in the kernel because the kernel isn't a DT validator.
That's all I'm saying. I think this comment is not useful if the driver
design is done to specify parent linkages in C code instead of DT, so
don't worry about this too much.

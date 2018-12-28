From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 07/14] clock: milbeaut: Add Milbeaut M10V clock control
Date: Thu, 27 Dec 2018 16:39:26 -0800
Message-ID: <154595756614.179992.794211301759568891@swboyd.mtv.corp.google.com>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com> <1542589274-13878-8-git-send-email-sugaya.taichi@socionext.com> <154356669840.88331.4455990896653868594@swboyd.mtv.corp.google.com> <9fba4689-b20f-c18a-ea11-d961de497ea3@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9fba4689-b20f-c18a-ea11-d961de497ea3@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Sugaya, Taichi" <sugaya.taichi@socionext.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Russell King <linux@armlinux.org.uk>, Jiri Slaby <jslaby@suse.com>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>
List-Id: linux-serial@vger.kernel.org

Quoting Sugaya, Taichi (2018-12-25 17:35:27)
> Hi
>=20
> On 2018/11/30 17:31, Stephen Boyd wrote:
> >> +       init.num_parents =3D parents;
> >> +       init.parent_names =3D parent_names;
> >> +
> >> +       mcm->cname =3D clk_name;
> >> +       mcm->parent =3D 0;
> >> +       mcm->hw.init =3D &init;
> >> +
> >> +       clk =3D clk_register(NULL, &mcm->hw);
> >> +       if (IS_ERR(clk))
> >> +               goto err_clk;
> >> +
> >> +       of_clk_add_provider(node, of_clk_src_simple_get, clk);
> >> +       return;
> >> +
> >> +err_clk:
> >> +       kfree(mcm);
> >> +err_mcm:
> >> +       kfree(parent_names);
> >> +}
> >> +CLK_OF_DECLARE(m10v_clk_mux, "socionext,milbeaut-m10v-clk-mux",
> >> +                       m10v_clk_mux_setup);
> >=20
> > Any chance you can use a platform driver?
> >=20
>=20
> Excuse me to re-ask you.
> Why do you recommend to use a platform driver? Is that current fad?

Not exactly a fad. We've been doing it for some time now. From an older
email on the list:

Reasons (in no particular order):

  1. We get a dev pointer to use with clk_hw_register()

  2. We can handle probe defer if some resource is not available

  3. Using device model gets us a hook into power management frameworks
     like runtime PM and system PM for things like suspend and hibernate

  4. It encourages a single DT node clk controller style binding
     instead of a single node per clk style binding

  5. We can use non-DT specific functions like devm_ioremap_resource() to m=
ap
     registers and acquire other resources, leading to more portable and
     generic code

  6. We may be able to make the device driver a module, which will
     make distros happy if we don't have to compile in all
     these clk drivers to the resulting vmlinux

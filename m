From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 08/18] serial: intel: Get serial id from dts
Date: Wed, 8 Aug 2018 10:33:25 +0200
Message-ID: <CAMuHMdVgC__AJHCEKT9UhdK4Jh4bm-s0ihH8mvx7KQ7+vzh6Ag@mail.gmail.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-9-songjun.wu@linux.intel.com> <CAMuHMdXkGchPN337dXbBVOFsb1o-Tkh8S_z=uCm3Z0sDjPVMKA@mail.gmail.com>
 <734bddbc-a5aa-d50d-0e7b-d8adc4d1afb2@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <734bddbc-a5aa-d50d-0e7b-d8adc4d1afb2@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: songjun.wu@linux.intel.com
Cc: hua.ma@linux.intel.com, yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com, Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-clk <linux-clk@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Hi Songjun,

On Wed, Aug 8, 2018 at 6:05 AM Wu, Songjun <songjun.wu@linux.intel.com> wrote:
> On 8/7/2018 3:33 PM, Geert Uytterhoeven wrote:
> > On Fri, Aug 3, 2018 at 5:04 AM Songjun Wu <songjun.wu@linux.intel.com> wrote:
> >> Get serial id from dts.
> >>
> >> "#ifdef CONFIG_LANTIQ" preprocessor is used because LTQ_EARLY_ASC
> >> macro is defined in lantiq_soc.h.
> >> lantiq_soc.h is in arch path for legacy product support.
> >>
> >> arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
> >>
> >> If "#ifdef preprocessor" is changed to
> >> "if (IS_ENABLED(CONFIG_LANTIQ))", when CONFIG_LANTIQ is not enabled,
> >> code using LTQ_EARLY_ASC is compiled.
> >> Compilation will fail for no LTQ_EARLY_ASC defined.
> >>
> >> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
> > Thanks for your patch!
> >
> >> @@ -699,9 +700,19 @@ lqasc_probe(struct platform_device *pdev)
> >>                  return -ENODEV;
> >>          }
> >>
> >> -       /* check if this is the console port */
> >> -       if (mmres->start != CPHYSADDR(LTQ_EARLY_ASC))
> >> -               line = 1;
> >> +       /* get serial id */
> >> +       line = of_alias_get_id(node, "serial");
> >> +       if (line < 0) {
> >> +#ifdef CONFIG_LANTIQ
> >> +               if (mmres->start == CPHYSADDR(LTQ_EARLY_ASC))
> >> +                       line = 0;
> >> +               else
> >> +                       line = 1;
> >> +#else
> >> +               dev_err(&pdev->dev, "failed to get alias id, errno %d\n", line);
> >> +               return line;
> > Please note that not providing a fallback here makes life harder when using
> > DT overlays.
> > See the description of commit 7678f4c20fa7670f ("serial: sh-sci: Add support
> > for dynamic instances") for background info.
> Thanks for your comment.
> The logic in commit 7678f4c20fa7670f is not suitable here.
> We need to know which serial instance is used for console.
> We cannot use dynamic serial instance here.

Why does the driver need to use which serial instance is used for the console?
Hardcoding that is not an option, as the board DTS may specify the console using
chosen/stdout-path.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

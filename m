From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 14/18] serial: intel: Add CCF support
Date: Tue, 7 Aug 2018 09:33:39 +0200
Message-ID: <CAMuHMdXADda8fuc9_oTGQFPUnYs8gX-Bp6md5fJgu=wHvM-duw@mail.gmail.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-15-songjun.wu@linux.intel.com> <20180803055640.GA32226@kroah.com>
 <763bba56-3701-7fe9-9b31-4710594b40d5@linux.intel.com> <20180803103023.GA6557@kroah.com>
 <3360edd2-f3d8-b860-13fa-ce680edbfd0a@hauke-m.de> <20180804124309.GB4920@kroah.com>
 <CAK8P3a3qs34LuhPeaef2wPHYEWbYO5N-4n7763BcaDyppiJ6DA@mail.gmail.com>
 <acd28f40-4342-7f67-8468-7d4578f614a1@linux.intel.com> <CAMuHMdWY9NuYOXq8sD9wmH48=vhMcSBomRY9ZbC+tGE3PGiTGg@mail.gmail.com>
 <0ab8e6e7-3cc2-8e50-b1f3-99616437f527@linux.intel.com> <CAMuHMdUJ8-bveoHWOetjrHtq2HNPnf00PidQwJ-kZD2o86KLMw@mail.gmail.com>
 <d6d0be20-aea9-cecf-1e39-3d65c0dbad5f@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d6d0be20-aea9-cecf-1e39-3d65c0dbad5f@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: songjun.wu@linux.intel.com
Cc: Arnd Bergmann <arnd@arndb.de>, Greg KH <gregkh@linuxfoundation.org>, Hauke Mehrtens <hauke@hauke-m.de>, hua.ma@linux.intel.com, yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com, Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-clk <linux-clk@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Hi Songjun,

On Tue, Aug 7, 2018 at 9:18 AM Wu, Songjun <songjun.wu@linux.intel.com> wrote:
> On 8/6/2018 5:29 PM, Geert Uytterhoeven wrote:
> > On Mon, Aug 6, 2018 at 10:58 AM Wu, Songjun <songjun.wu@linux.intel.com> wrote:
> >> The reason we add a new head file is also for two macros(LTQ_EARLY_ASC
> >> and CPHYSADDR)
> >> used by legacy product. We need to provide the no-op stub for these two
> >> macro for new product.
> > No you don't. The line number should not be obtained by comparing the
> > resource address with a hardcoded base address.
> This is the previous code. Now the line number is obtained from dts.

Note that obtaining line numbers from DTS has its own share of problems, when
considering DT overlays. I've replied to the patch adding the call to
of_alias_get_id().

> We keep this code for the compatibility.
>
> Referring to the conditional-compilation part in coding-style,
> We add a header file to avoid using “#ifdef” in C file.
> > Perhaps the override of port->line should just be removed, as IIRC, the serial
> > core has already filled in that field with the (next available) line number?

Gr{oetje,eeting}s,

                        Geert--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

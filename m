From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 9/9] serial: xuartps: Fix out-of-bounds access through DT
 alias
Date: Tue, 20 Feb 2018 13:27:53 +0100
Message-ID: <CAMuHMdWe9XkoDKkyfu1pOG0oS0_Tdx1w=OOk05EvTr_dK=tp7Q@mail.gmail.com>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
 <1519119624-1268-10-git-send-email-geert+renesas@glider.be>
 <c16b025a-a302-8515-2697-f7eca478e939@xilinx.com>
 <CAMuHMdUOKMM5mSrnnrxCi0gX_TbjYkj7vwn11b2D5p7XigM+Ag@mail.gmail.com>
 <6cabf7c6-302e-efa9-8f4d-25fd35ecddad@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <6cabf7c6-302e-efa9-8f4d-25fd35ecddad@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Barry Song <baohua@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Vineet Gupta <vgupta@synopsys.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, arcml <linux-snps-arc@lists.infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi Michal,

On Tue, Feb 20, 2018 at 12:27 PM, Michal Simek <michal.simek@xilinx.com> wrote:
> On 20.2.2018 11:38, Geert Uytterhoeven wrote:
>> On Tue, Feb 20, 2018 at 11:22 AM, Michal Simek <michal.simek@xilinx.com> wrote:
>>> On 20.2.2018 10:40, Geert Uytterhoeven wrote:
>>>> The cdns_uart_port[] array is indexed using a value derived from the
>>>> "serialN" alias in DT, which may lead to an out-of-bounds access.
>>>>
>>>> Fix this by adding a range check.

> I have checked 4 patches I have sent in past which didn't reach mainline
> (probably because of RFC)
> Take a look at
> https://www.spinics.net/lists/linux-serial/msg27106.html
>
> I have removed cdns_uart_port array completely there.

Nice! I'd love to get rid of fixed arrays in serial...

However, IMHO it's still worthwhile to fix the out-of-bounds access first,
as that fix can be backported to stable kernels easily.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

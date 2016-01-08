From: Martin Fuzzey <mfuzzey@parkeon.com>
Subject: Re: [PATCH V2] serial: imx: Fix suspend / resume.
Date: Fri, 8 Jan 2016 12:13:33 +0100
Message-ID: <568F99DD.50809@parkeon.com>
References: <20160105155331.6024.7211.stgit@localhost>
 <CAOMZO5BES=YkYjtjPE_=t9Qa11JsgE0TT8-v0CxmtgSuBwWnmw@mail.gmail.com>
 <CAOMZO5ADYomDf5EbGAAPJSjEQFOfKi_r7j+xytSuQA5dQh=V0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAOMZO5ADYomDf5EbGAAPJSjEQFOfKi_r7j+xytSuQA5dQh=V0Q@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Sascha Hauer <kernel@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On 08/01/16 00:51, Fabio Estevam wrote:
> On Thu, Jan 7, 2016 at 9:17 PM, Fabio Estevam <festevam@gmail.com> wrote:
>
>> [   39.487313] [<c05844d0>] (snd_soc_suspend) from [<c03c31f0>]
> Ok, in this case it is an ALSA issue, so will start a thread at the
> alsa mailing list.
Ah,

Just seen I have this in my tree for that:

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a1305f8..a7ddf69 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -584,6 +584,9 @@ int snd_soc_suspend(struct device *dev)
         if (!card->instantiated)
                 return 0;

+       if (!card->snd_card)
+               return 0;
+
         /* Due to the resume being scheduled into a workqueue we could
         * suspend before that's finished - wait for it to complete.
          */
@@ -814,6 +817,9 @@ int snd_soc_resume(struct device *dev)
         if (!card->instantiated)
                 return 0;

+       if (!card->snd_card)
+               return 0;
+
         /* activate pins from sleep state */



I have that in my old 3.19 tree too so it's not new.

I didn't submit it because I haven't investigated further to see if it 
was just papering over the real problem..

Martin

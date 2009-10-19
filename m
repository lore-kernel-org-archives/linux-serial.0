From: Komuro <komurojun-mbn@nifty.com>
Subject: Re: [PATCH 1/9] serial_cs: use pcmcia_loop_config() and
	pre-determined values
Date: Mon, 19 Oct 2009 21:06:57 +0900 (JST)
Message-ID: <4012584.17381255954017391.komurojun-mbn@nifty.com>
References: <1255907255-28297-1-git-send-email-linux@dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org>
In-Reply-To: <1255907255-28297-1-git-send-email-linux@dominikbrodowski.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-pcmcia/>
List-Post: <mailto:linux-pcmcia@lists.infradead.org>
List-Help: <mailto:linux-pcmcia-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=subscribe>
Sender: linux-pcmcia-bounces@lists.infradead.org
Errors-To: linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, linux-pcmcia@lists.infradead.org, Dominik Brodowski <linux@dominikbrodowski.net>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

Please don't remove the code below.
This code loades the "2nd" ConfigBase of the multi-function card.



> static int serial_config(struct pcmcia_device * link)
> {
> 	struct serial_info *info = link->priv;
>-	struct serial_cfg_mem *cfg_mem;
>-	tuple_t *tuple;
>-	u_char *buf;
>-	cisparse_t *parse;
>-	cistpl_cftable_entry_t *cf;
>-	int i, last_ret, last_fn;
>+	int i;
> 
> 	DEBUG(0, "serial_config(0x%p)\n", link);
> 
>-	cfg_mem = kmalloc(sizeof(struct serial_cfg_mem), GFP_KERNEL);
>-	if (!cfg_mem)
>-		goto failed;
>-
>-	tuple = &cfg_mem->tuple;
>-	parse = &cfg_mem->parse;
>-	cf = &parse->cftable_entry;
>-	buf = cfg_mem->buf;
>-
>-	tuple->TupleData = (cisdata_t *) buf;
>-	tuple->TupleOffset = 0;
>-	tuple->TupleDataMax = 255;
>-	tuple->Attributes = 0;
>-
>-	/* Get configuration register information */
>-	tuple->DesiredTuple = CISTPL_CONFIG;
>-	last_ret = first_tuple(link, tuple, parse);
>-	if (last_ret != 0) {
>-		last_fn = ParseTuple;
>-		goto cs_failed;
>-	}
>-	link->conf.ConfigBase = parse->config.base;
>-	link->conf.Present = parse->config.rmask[0];
>-

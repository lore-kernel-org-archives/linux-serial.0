From: Komuro <komurojun-mbn@nifty.com>
Subject: Re: Re: [PATCH 1/9] serial_cs: use pcmcia_loop_config() and
	pre-determined values
Date: Wed, 21 Oct 2009 21:30:20 +0900 (JST)
Message-ID: <20949843.18491256128220708.komurojun-mbn@nifty.com>
References: <20091019123739.GA23104@isilmar.linta.de>
	<1255907255-28297-1-git-send-email-linux@dominikbrodowski.net>
	<4012584.17381255954017391.komurojun-mbn@nifty.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org>
In-Reply-To: <20091019123739.GA23104@isilmar.linta.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-pcmcia/>
List-Post: <mailto:linux-pcmcia@lists.infradead.org>
List-Help: <mailto:linux-pcmcia-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=subscribe>
Sender: linux-pcmcia-bounces@lists.infradead.org
Errors-To: linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, linux-pcmcia@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

>On Mon, Oct 19, 2009 at 09:06:57PM +0900, Komuro wrote:
>> Please don't remove the code below.
>> This code loades the "2nd" ConfigBase of the multi-function card.
>
>isn't this properly handled by the patch 
>
>pcmcia: pccard_read tuple and TUPLE_RETURN_COMMON cleanup


OK.
works.

Best Regards
Komuro

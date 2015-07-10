From: Rama Kiran Kumar Indrakanti <indrakanti_ram@hotmail.com>
Subject: RE: [PATCH 2/2] tty: serial: Drop owner assignment from i2c_driver
Date: Fri, 10 Jul 2015 14:27:41 +0530
Message-ID: <SNT151-W93183F2B334F279A74EC86E79F0@phx.gbl>
References: <1436510180-5567-1-git-send-email-k.kozlowski@samsung.com>,<1436510180-5567-3-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436510180-5567-3-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

<br><br>&gt; From: k.kozlowski@samsung.com<br>&gt; To: gregkh@linuxfoundation.org; jslaby@suse.cz; ralf@linux-mips.org; k.kozlowski@samsung.com; paul.burton@imgtec.com; linux-serial@vger.kernel.org; linux-kernel@vger.kernel.org<br>&gt; Subject: [PATCH 2/2] tty: serial: Drop owner assignment from i2c_driver<br>&gt; Date: Fri, 10 Jul 2015 15:36:20 +0900<br>&gt; <br>&gt; i2c_driver does not need to set an owner because i2c_register_driver()<br>&gt; will set it.<br>&gt; <br>&gt; Signed-off-by: Krzysztof Kozlowski &lt;k.kozlowski@samsung.com&gt;<br>&gt; <br>&gt; ---<br>&gt; <br>&gt; The coccinelle script which generated the patch was sent here:<br>&gt; http://www.spinics.net/lists/kernel/msg2029903.html<br>&gt; ---<br>&gt;  drivers/tty/serial/sc16is7xx.c | 1 -<br>&gt;  1 file changed, 1 deletio
 n(-)<br>&gt; <br>&gt; diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c<br>&gt; index 9e6576004a42..bbeb33561737 100644<br>&gt; --- a/drivers/tty/serial/sc16is7xx.c<br>&gt; +++ b/drivers/tty/serial/sc16is7xx.c<br>&gt; @@ -1369,7 +1369,6 @@ MODULE_DEVICE_TABLE(i2c, sc16is7xx_i2c_id_table);<br>&gt;  static struct i2c_driver sc16is7xx_i2c_uart_driver = {<br>&gt;  	.driver = {<br>&gt;  		.name		= SC16IS7XX_NAME,<br>&gt; -		.owner		= THIS_MODULE,<br><br>Okay, is there an issue by doing this. Or its just a over doing things ?<br><br>&gt;  		.of_match_table	= of_match_ptr(sc16is7xx_dt_ids),<br>&gt;  	},<br>&gt;  	.probe		= sc16is7xx_i2c_probe,<br>&gt; -- <br>&gt; 1.9.1<br>&gt; <br>&gt; --<br>&gt; To unsubscribe from this list: send the line "unsubscribe linux-serial" 
 in<br>&gt; the body of a message to majordomo@vger.kernel.org<br>&gt; More majordomo info at  http://vger.kernel.org/majordomo-info.html<br> 		 	   		  
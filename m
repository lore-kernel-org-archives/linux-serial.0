From: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] serial/bcm63xx_uart: use correct alias naming
Date: Fri, 10 Jun 2016 13:48:24 -0700
Message-ID: <575B2798.9000801@gmail.com>
References: <1465380523-7385-1-git-send-email-jogo@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1465380523-7385-1-git-send-email-jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Arlott <simon-A6De1vDTPLDsq35pWSNszA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 06/08/2016 03:08 AM, Jonas Gorski wrote:
> The bcm63xx_uart driver uses the of alias for determing its id. Recent
> changes in dts files changed the expected 'uartX' to the recommended
> 'serialX', breaking serial output. Fix this by checking for a 'serialX'
> alias as well.
> 
> Fixes: e3b992d028f8 ("MIPS: BMIPS: Improve BCM6328 device tree")
> Fixes: 2d52ee82b475 ("MIPS: BMIPS: Improve BCM6368 device tree")
> Fixes: 7537d273e2f3 ("MIPS: BMIPS: Add device tree example for BCM6358")
> Signed-off-by: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>

Acked-by: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

A future improvement could be to completely get rid of the id and
instead just dynamically allocate the ports structure.
-- 
Florian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

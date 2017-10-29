From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 1/3] MIPS: AR7: defer registration of GPIO
Date: Sun, 29 Oct 2017 10:33:20 -0700
Message-ID: <fe7b4311-b013-b372-68d3-67a656eaf8f2@gmail.com>
References: <20171029152721.6770-1-jonas.gorski@gmail.com>
 <20171029152721.6770-2-jonas.gorski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20171029152721.6770-2-jonas.gorski@gmail.com>
Content-Language: en-US
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Jonas Gorski <jonas.gorski@gmail.com>, linux-mips@linux-mips.org, linux-serial@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>, Nicolas Schichan <nschichan@freebox.fr>
List-Id: linux-serial@vger.kernel.org



On 10/29/2017 08:27 AM, Jonas Gorski wrote:
> When called from prom init code, ar7_gpio_init() will fail as it will
> call gpiochip_add() which relies on a working kmalloc() to alloc
> the gpio_desc array and kmalloc is not useable yet at prom init time.
> 
> Move ar7_gpio_init() to ar7_register_devices() (a device_initcall)
> where kmalloc works.
> 
> Fixes: 14e85c0e69d5 ("gpio: remove gpio_descs global array")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

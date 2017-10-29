From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 2/3] MIPS: AR7: ensure that serial ports are properly set
 up
Date: Sun, 29 Oct 2017 10:33:33 -0700
Message-ID: <c54dae81-5c22-1ccd-4b96-15dab6e603f2@gmail.com>
References: <20171029152721.6770-1-jonas.gorski@gmail.com>
 <20171029152721.6770-3-jonas.gorski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20171029152721.6770-3-jonas.gorski@gmail.com>
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
Cc: Ralf Baechle <ralf@linux-mips.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>, Nicolas Schichan <nschichan@freebox.fr>, Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
List-Id: linux-serial@vger.kernel.org



On 10/29/2017 08:27 AM, Jonas Gorski wrote:
> From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> 
> without UPF_FIXED_TYPE, the data from the PORT_AR7 uart_config entry is
> never copied, resulting in a dead port.
> 
> Fixes: 154615d55459 ("MIPS: AR7: Use correct UART port type")
> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> [jonas.gorski: add Fixes tag]
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

-- 
Florian

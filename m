From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] serial: samsung: Remove redundant DEBUG_LL check
Date: Tue, 14 Jul 2015 10:56:31 +0900
Message-ID: <55A46C4F.8050803@samsung.com>
References: <1436786331-5188-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1436786331-5188-1-git-send-email-javier@osg.samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-samsung-soc@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 13.07.2015 20:18, Javier Martinez Canillas wrote:
> Commit 84f57d9e3685 ("tty: serial/samsung: fix modular build") fixed
> build issues when the driver was built as a module. One of those was
> that printascii is only accessible when the driver is built-in.
> 
> But there is no need to check for defined(CONFIG_DEBUG_LL) since the
> SERIAL_SAMSUNG_DEBUG Kconfig symbol already depends on DEBUG_LL.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
>  drivers/tty/serial/samsung.c | 1 -
>  1 file changed, 1 deletion(-)

Although this redundancy is not harmful the patch seems fine, so:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

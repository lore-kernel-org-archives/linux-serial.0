From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH-stable] serial: samsung: Bring back removed variable to
 fix compilation
Date: Thu, 18 May 2017 14:59:32 +0200
Message-ID: <CAJKOXPdEQ-JSSZK1PA4xc1f7NWdKNyaeQ3qyjEdW7ttTvTF4og@mail.gmail.com>
References: <1495110677-31174-1-git-send-email-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1495110677-31174-1-git-send-email-krzk@kernel.org>
Sender: stable-owner@vger.kernel.org
To: Krzysztof Kozlowski <kozik.server@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, May 18, 2017 at 2:31 PM, Krzysztof Kozlowski
<kozik.server@gmail.com> wrote:

I need to fixup the from field. It should be krzk@kernel.org.

Krzysztof


> By mistake commit 500fcc08a32b ("serial: samsung: Add missing checks for
> dma_map_single failure") removes a local variable which is still used by
> code.  After backporting the commit to stable, compilation fails:
>
>         drivers/tty/serial/samsung.c: In function ‘s3c24xx_serial_request_dma’:
>         drivers/tty/serial/samsung.c:909:45: error: ‘flags’ undeclared (first use in this function)
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> Fix for stable-rc commit:
> bc3ac2299c4873cdc7f9bf3c867c23e9714a036f
> ---
>  drivers/tty/serial/samsung.c | 1 +
>  1 file changed, 1 insertion(+)

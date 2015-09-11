From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 2/4] serial: samsung: remove unneded 'ignore_char' label
Date: Fri, 11 Sep 2015 14:58:57 +0900
Message-ID: <55F26DA1.40206@samsung.com>
References: <1441892476-14273-1-git-send-email-r.baldyga@samsung.com>
 <1441892476-14273-3-git-send-email-r.baldyga@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1441892476-14273-3-git-send-email-r.baldyga@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Baldyga <r.baldyga@samsung.com>, gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, m.szyprowski@samsung.com
List-Id: linux-serial@vger.kernel.org

On 10.09.2015 22:41, Robert Baldyga wrote:
> This label does nothing special and we don't need to have it anymore.
> 
> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> ---
>  drivers/tty/serial/samsung.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

From: Robert Baldyga <r.baldyga@samsung.com>
Subject: Re: [PATCH 2/3] serial: samsung: remove unneded 'ignore_char' label
Date: Thu, 10 Sep 2015 12:30:18 +0200
Message-ID: <55F15BBA.7090609@samsung.com>
References: <1441705127-24125-1-git-send-email-r.baldyga@samsung.com>
 <1441705127-24125-3-git-send-email-r.baldyga@samsung.com>
 <55F0CE80.3030400@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <55F0CE80.3030400@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, m.szyprowski@samsung.com
List-Id: linux-serial@vger.kernel.org

On 09/10/2015 02:27 AM, Krzysztof Kozlowski wrote:
> On 08.09.2015 18:38, Robert Baldyga wrote:
>> This label does nothing special and we don't need to have it anymore.
>>
>> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
>> ---
>>  drivers/tty/serial/samsung.c | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> Label does nothing but it has a meaning. It serves as a comment - ignore
> the character. So maybe:
> 
> -					goto ignore_char;
> +					continue; /* Ignore character */
> 
> What do you think?

Look good to me.

Thanks,
Robert

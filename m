From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH 0/3] tty/serial/ucc_uart: Adjustments for two functions
Date: Wed, 6 Dec 2017 16:22:18 -0600
Message-ID: <cf5c7c5d-ceee-58bd-1dfb-8f9dff48abe3@tabi.org>
References: <5c6d363d-398b-4695-78c3-33b9e8dbffa3@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5c6d363d-398b-4695-78c3-33b9e8dbffa3@users.sourceforge.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 12/06/2017 03:10 PM, SF Markus Elfring wrote:
> 
> Three update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (3):
>    Delete an error message for a failed memory allocation in ucc_uart_probe()
>    Improve a size determination in ucc_uart_probe()
>    Fix a typo in a comment line

All three:

Acked-by: Timur Tabi <timur@tabi.org>

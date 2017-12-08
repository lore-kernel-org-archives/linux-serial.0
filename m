From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 1/2] serial: tegra: Delete an error message for a failed
 memory allocation in tegra_uart_probe()
Date: Fri, 8 Dec 2017 10:42:03 +0000
Message-ID: <b19da0a2-6164-6c66-c191-576f4d48537e@nvidia.com>
References: <605adc2b-3591-86fc-410a-370f48dfb14e@users.sourceforge.net>
 <aee3d79d-a59e-a3fd-6c6b-45ee46132cc6@users.sourceforge.net>
 <cced0e90-61b1-2182-a2b3-327ee9394190@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cced0e90-61b1-2182-a2b3-327ee9394190@nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>, SF Markus Elfring <elfring@users.sourceforge.net>, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


On 08/12/17 09:37, Laxman Dewangan wrote:
> On Friday 08 December 2017 01:49 AM, SF Markus Elfring wrote:
>> From: Markus Elfring <elfring@users.sourceforge.net>
>> Date: Thu, 7 Dec 2017 21:00:05 +0100
>>
>> Omit an extra message for a memory allocation failure in this function.
>>
>> This issue was detected by using the Coccinelle software.
>>
> 
> Acked-by: Laxman Dewangan <ldewangan@nvidia.com>

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic

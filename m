From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: Re: [PATCH v7 0/5] ACPI: parse the SPCR table
Date: Thu, 12 May 2016 14:52:02 +0300
Message-ID: <bc91f503-cee5-db03-51bf-a36ef3e95a1f@linaro.org>
References: <1459431629-27934-1-git-send-email-aleksey.makarov@linaro.org>
 <1bff98e3-2d94-ed76-1165-ed7d43bbfcf3@jonmasters.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1bff98e3-2d94-ed76-1165-ed7d43bbfcf3@jonmasters.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Jon Masters <jcm@jonmasters.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Zheng, Lv" <lv.zheng@intel.com>
List-Id: linux-serial@vger.kernel.org

Hi Jon,

In v7 I addressed the issues that were brought up by Rafael J . Wysocki
(but I still do not have ACK from ACPI people).

The issue with D02 will be addressed in a separate patch.

There possibly is an issue with 16550 and command line console with I am
investigating and probably will address in a separate patch.

I know no other problems with it and reviewers seem happy.

So I believe this patchset could be pulled.  If needed, I will send v8.

Thank you
Aleksey Makarov

On 05/12/2016 11:20 AM, Jon Masters wrote:
> On 03/31/2016 09:40 AM, Aleksey Makarov wrote:
> 
>> 'ARM Server Base Boot Requirements' [1] mentions SPCR (Serial Port
>> Console Redirection Table) [2] as a mandatory ACPI table that
>> specifies the configuration of serial console.
> 
> Hi Aleksey,
> 
> Can you summarize the status of this patch series?
> 
> Jon.
> 

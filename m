From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: earlycon: no match?
Date: Mon, 04 May 2015 16:34:56 -0400
Message-ID: <5547D7F0.6000604@hurleysoftware.com>
References: <20150503211054.GR15254@pengutronix.de> <55477BC1.6000805@hurleysoftware.com> <20150504202223.GT6325@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150504202223.GT6325@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Robert Schwebel <r.schwebel@pengutronix.de>, kernel@pengutronix.de, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 05/04/2015 04:22 PM, Sascha Hauer wrote:
> On Mon, May 04, 2015 at 10:01:37AM -0400, Peter Hurley wrote:
>> Hi Robert,
>>
>> On 05/03/2015 05:10 PM, Robert Schwebel wrote:
>>> Hi Peter,
>>>
>>> with 4.1-rc1, my boxes with early console enabled show something like
>>> this (the example is vexpress, but it for example also happens on an
>>> AM335x board):
>>>
>>>   earlycon: no match for ttyAMA0,38400n8
>>
>> This shouldn't impact any previous earlycon setup. Are you saying
>> you're seeing a regression?
>>
>> How do you have early console enabled, via the command line or via DT?
> 
> What happens here is that Robert has console=ttyAMA0,38400n8 in his
> command line.

Yeah, thanks, that much is now clear from his second email.

> In init/main.c we have:
> 
> static int __init do_early_param(char *param, char *val, const char *unused)
> {
> 	const struct obs_kernel_param *p;
> 
> 	for (p = __setup_start; p < __setup_end; p++) {
> 		if ((p->early && parameq(param, p->str)) ||
> 		    (strcmp(param, "console") == 0 &&
> 		     strcmp(p->str, "earlycon") == 0)
> 		) {
> 			if (p->setup_func(val) != 0)
> 				pr_warn("Malformed early option '%s'\n", param);
> 		}
> 	}
> 	/* We accept everything at this stage. */
> 	return 0;
> }
> 
> This means that param_setup_earlycon() gets called with the arguments
> passed to the console= parameter which makes no sense in this context
> and leads to the "no match for" message.

Right, except that "the context" has insufficient information to differentiate
an error, such as a misspelled earlycon name, from any other use.

Regards,
Peter Hurley

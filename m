From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v3 5/7] ACPI: serial: implement earlycon on ACPI DBG2 port
Date: Fri, 4 Mar 2016 07:52:00 -0800
Message-ID: <56D9AF20.1060701@hurleysoftware.com>
References: <1456749726-30261-1-git-send-email-aleksey.makarov@linaro.org>
 <1456749726-30261-6-git-send-email-aleksey.makarov@linaro.org>
 <56D5BAFF.6080008@hurleysoftware.com> <56D5C9F5.5060301@linaro.org>
 <56D878D4.4000902@hurleysoftware.com> <56D987BC.7070209@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <56D987BC.7070209@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>, linux-acpi@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Matthias Brugger <mbrugger@suse.com>, Jonathan Corbet <corbet@lwn.net>, Jiri Slaby <jslaby@suse.com>, linux-doc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 03/04/2016 05:03 AM, Aleksey Makarov wrote:

> Actually it was Mark Salter who asked to introduce such macros.
> 
> https://lkml.kernel.org/g/1441730339.5459.8.camel@redhat.com

I wasn't copied on that series, sorry.


> I think reusing the OF functions is a good decision.

But you're not reusing the OF functions; you're duplicating them.

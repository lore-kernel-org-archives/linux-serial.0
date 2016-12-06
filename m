From: Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH] SPCR: check bit width for the 16550 UART
Date: Mon, 5 Dec 2016 19:05:01 -0500
Message-ID: <7dc247ac-e557-a750-d23d-92c55630cb1d@redhat.com>
References: <20161205130534.11080-1-aleksey.makarov@linaro.org>
 <CADaLND=cpfnrNUAR+hHBjMk=ei50Z=TFhgzDy0T+EkqUuM7ZWQ@mail.gmail.com>
 <c5bc8527-4dbc-8411-a441-7e7aebcbbfed@redhat.com>
 <CADaLNDn9ZVaZNc0B6_gJ7wBUBPne4qNpYeiPmUO7_SBzsW+srA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CADaLNDn9ZVaZNc0B6_gJ7wBUBPne4qNpYeiPmUO7_SBzsW+srA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Duc Dang <dhdang@apm.com>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Mark Salter <msalter@redhat.com>, Graeme Gregory <graeme.gregory@linaro.org>, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org

On 12/05/2016 06:52 PM, Duc Dang wrote:

> But I am still curious why setting subtype to '0' does not work on
> your board. Are you using Mustang or m400?

m400 with updated tables (that are correctly overriding not appending)
provided via INITRD override. I am looking at why it's not working.

[    0.000000] ACPI: Table Upgrade: override [SPCR-HPE   -ProLiant]
[    0.000000] ACPI: SPCR 0x0000004FF7F30000 Physical table override, new table: 0x0000004FFFFF0000
[    0.000000] ACPI: SPCR 0x0000004FFFFF0000 000050 (v02 HPE    ProLiant 00001337 INTL 20160527)

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop


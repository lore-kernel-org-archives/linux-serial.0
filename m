From: Paul Menzel <pmenzel+linux-serial@molgen.mpg.de>
Subject: How to enable output to serial console at run-time?
Date: Thu, 2 Nov 2017 16:39:36 +0100
Message-ID: <3c348fe1-1474-6c19-691d-8130d4bd0d32@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Dear Linux folks,


If I want to output the Linux kernel messages to the serial console, but 
the `console=ttyS…` line is missing on the Linux command line, is there 
a way to activate that during run-time by, for example, using the sysfs 
interface?


Kind regards,

Paul

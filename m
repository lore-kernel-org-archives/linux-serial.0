From: "Cigol C" <linuxppp@indiainfo.com>
Subject: RS485 communication
Date: Mon, 24 Mar 2003 17:13:07 +0530
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030324114308.30965.qmail@indiainfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-ppp@vger.kernel.org
Cc: redhat-ppp-list@redhat.com, linux-kernel@vger.kernel.org

Hi all,
Regarding RS485 communication I thank all of them for their responses. I finally decided to write a custom Layer 2 char driver or protocol to pave way for my IP over RS485 communication. I will like to get some inputs/docs/references on linux-ppp implementation. ISo am in the process of browsing the PPP code and exploring the interface it has with the serial driver which is crucial for me. Regarding this I request for more clarity on following: 
i) Linux PPP interface with IP: Registration, Packet send/receive/close
ii) Linux PPP interface with serial driver:Registration, Packet send/receive/close
iii) Linux PPP server configuration and initial sequence of working. i.e. associating a IP address with serial device and ppp0

I will be grateful if somebody could help me on this.
Thanks and Best Regards
Karthik
-- 
______________________________________________
http://www.indiainfo.com
Now with POP3/SMTP access for only US$14.95/yr

Powered by Outblaze

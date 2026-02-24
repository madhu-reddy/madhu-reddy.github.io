---
layout: post
title: What is the difference between IAM role and instance profile?
date: 2022-12-24
categories: ['AWS', 'IAM']
---

**IAM Roles** 
An IAM role, akin to an IAM user, is an AWS identity with attached IAM policies that dictate the actions the identity is allowed or disallowed to perform in AWS.

IAM roles provide a secure method for granting permissions to your EC2 instances. By utilizing an IAM role, an EC2 instance can obtain temporary credentials for accessing AWS services without the need to hardcode access keys within the instance.

For instance, if an EC2 instance requires access to a specific S3 bucket to upload a file, you can create an IAM role with the necessary IAM policy defined and attached. Subsequently, you can associate this role with the EC2 instance.

Now I have created an S3 bucket named `madhu-testing` for demonstration.

![]({{site.baseurl}}/assets/img/2022/12/image-5.png)

Now, I will attempt to upload a file to the S3 bucket from the EC2 instance I created earlier and observe the outcome.

![]({{site.baseurl}}/assets/img/2022/12/image-6.png)

As evident from the above screenshot, the file upload to the S3 bucket has failed, as expected, since we have not attached any IAM role to the EC2 instance yet.

Next, I will create an IAM role named `"madhu-test-role"` and associate the policy `"AmazonS3FullAccess"` with it. For testing purposes, I've chosen an existing policy that grants full access to S3. However, for a more granular approach, you can create a custom IAM policy providing access only to the specific S3 bucket required by the EC2 instance.

![]({{site.baseurl}}/assets/img/2022/12/image-7.png)

Next, I will attach the IAM role to the EC2 instance.

![]({{site.baseurl}}/assets/img/2022/12/image-8.png)

I will now retest the file upload to S3 from the EC2 instance, and this time, the file upload is successful to the S3 bucket.

![]({{site.baseurl}}/assets/img/2022/12/image-9.png)

.

**Instance Profile** 
An instance profile serves as a container for an IAM role, allowing you to pass the IAM role to an EC2 instance. Each instance profile can accommodate only one IAM role, though a role has the flexibility to belong to multiple instance profiles.

When you create an IAM Role for EC2 using the IAM Console, both an EC2 instance profile and an IAM role with matching names are generated.

In the process of attaching an IAM role to an EC2 instance, the UI console might give the impression that you are selecting an IAM role. However, you are, in fact, choosing an instance profile that shares the same name as your role.

![]({{site.baseurl}}/assets/img/2022/12/image-17.png)
